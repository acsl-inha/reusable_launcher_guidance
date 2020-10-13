%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: GCU.m                                                         %
%                                                                         %
%                               - Created by B. S. Kim, 2020. 07. 13.     %
%                                                                         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global and Persistent Variables 

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim 
    
    
    %%  Get Initial position & velocity in Landing Coordinate System (NED)
%.. Importing Data 

    Rbii            =       outDyn.Rbii ; 
    Vbii            =       outDyn.Vbii ; 
    Mass            =       outDyn.Mass ; 
    cE_L            =       outDyn.cE_L ; 
    Rlie            =       outDyn.Rlie ; 
    
    
%.. Landing Coordinate System

    % Body Position and Velocity in ECEF
    cI_E            =       GetDCM_I2E( datUnit.Omega * datSim.Time );      % DCM from I-Coord. to E-Coord. 
    Rbie            =       cI_E * Rbii ;                                   % Body Position w.r.t. Earth Center in E-Coord. 
    Vbie            =       cI_E * Vbii ;                                   % Body Velocity w.r.t. Earth Center in E-Coord.  

    % Geocentric and Geodetic Positions 

    Pos_Geoc        =       CnvPos_E2C( Rbie ) ;                            % Body Position in Geocentric. 
    Pos_Geod        =       CnvPos_E2D( Rbie ) ;                            % Body Position in Geodetic. 
    
    % DCM from E- Coord. to D-Coord. 
    cE_D            =       GetDCM_E2D( Pos_Geod ) ;                      	
    
    % Body Geographic Velocity (w.r.t. Earth) 
    Weii         	=       [ 0.0 ; 0.0 ; datUnit.Omega ] ;                 % Earth Angular Velocity w.r.t. I-Frame in I-Coord. 
    Vbei         	=       Vbii - cross( Weii, Rbii )  ;                 	% Body Velocity w.r.t. Earth(any poin on Earth) in I-Coord. 
    cI_D            =       cE_D * cI_E ;                                   % DCM from I-Coord. to D-Coord. 
    Vbed        	=       cI_D * Vbei ;                                   % Body Velocity w.r.t. Earth(any poin on Earth) in D-Coord.

    % Velocity Angles from Geographic Velocity 
    angVbed      	=       GetAngle( Vbed ) ;                              % Heading and Flight Path Angles 
    
    % DCM from Geodetic to Velocity Coordinate
    cD_V        	=       GetAng2DCM( angVbed ) ;                         
    
    % Body Position w.r.t.Landing Point in L-Coords. 
    Rble            =       Rbie - Rlie ;                                   % Body Position w.r.t. Landing Point in E-Coord. 
    Rbll            =       cE_L * Rble ;                                   % Body Position w.r.t. Landing Point in L-Coord.
    
    % Body Velocity w.r.t. Landing Point in L-Coords. 
    Wlii            =       [ 0.0 ; 0.0 ; datUnit.Omega ] ;                 % Landing Point Angular Velocity w.r.t. I-Frame in I-Coord. 
    Vbli            =       Vbii - cross( Wlii, Rbii ) ;                    % Body Velocity w.r.t. Landing Point in I-Coord. 
    cI_L            =       cE_L * cI_E ;                                   % DCM from I-Coord. to L-Coord. 
    Vbll            =       cI_L * Vbli ;                                   % Body Velocity w.r.t. Landing Point in L-Coord.     
    
    position        =       Rbll ;                                          % L-Coord position
    velocity        =       Vbll ;                                          % L-Coord velocity
    
   
    %% GetThrust in Landing Coordinate System(NED)
    %.. GCU Module

    % Thrust ( Your Guidance Command, L-Frame )
    if(abs(position(3))<2)
        [N,E,D]             =       Compute_cvx_Euler_Velocity_zero(position,velocity,N_upper);
        Thr_Cmd             =       [N;E;D];
        outGCU.Thr_Cmd      =       Thr_Cmd ;
        datSim.tf           =       datSim.tf - datSim.dt;
        
    else
        
            N_upper             =     fix(abs( position(3) / velocity(3))/datSim.dt);
            N_lower             =     0;
            Epsilon             =     1;
            
        % Find optimal final time
            Thr_Cmd = [0; 0; 0];
            Thr_Cmd = Compute_cvx_Euler(position,velocity,N_upper);              % Check Inf & Feasible
            if(Thr_Cmd == 0)                                                      % Infeasible
                while(1)
                    N_lower =  N_upper;                                         % Change Lower bound
                    N_upper =  N_upper + N_upper;                               % Change Upper bound
                    Thr_Cmd = Compute_cvx_Euler(position,velocity,N_upper);
                    if(Thr_Cmd == 0)                                              % Infeasible
                        continue
                    else
                        break
                    end       
                end
            end
            Thr_Cmd
            datSim.tf = N_upper * datSim.dt;
            while(N_upper - N_lower > Epsilon)
                S     =     fix( 0.5 * ( N_upper + N_lower));
                Thr_Cmd =     Compute_cvx_Euler(position,velocity,S); 
                if(Thr_Cmd == 0)                                                
                    N_lower  = S;                                             % Infeasible --> Change Lower bound
                else
                    N_upper  = S;                                             % Feasible  --> Change Upper bound                                 
                    datSim.tf = N_upper * datSim.dt;
                end
            end
        

    %.. Exporting Data

        outGCU.Thr_Cmd = 	Thr_Cmd ;
        
    
    end
    