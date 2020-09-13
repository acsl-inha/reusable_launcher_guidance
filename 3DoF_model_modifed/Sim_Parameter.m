%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Sim_Parameter.m                                               %
%   - Setting the parameters required for the simulation.                 %
%                                                                         %
%                               - Created by B. S. Kim, 2020. 07. 13.     %
%                               - Modified by C. H. Lee, 2020. 07. 19.    %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%


% test
%.. Global Variables 

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim
    
%.. Simulation Setting


    datSim.tf               =   15 ;
    datSim.dt               =   1; 
    datSim.nStep            =   fix( datSim.tf / datSim.dt ) ;
    datSim.iRun             =   0; 
    
%.. Unit b

    datUnit.R2D             =   180/pi ;
    datUnit.D2R             =   pi/180 ;
    datUnit.Rmean         	=   6370987.308 ;                               % Mean Earth Radius                             [m]                                                                                                                            (m/s^2)
    datUnit.G           	=   6.673e-11 ;                                 % Universal Gravitational Constant              [Nm^2/kg^2]
    datUnit.E_mass       	=   5.973e24 ;                                  % Mass of the Earth                             [kg]
    datUnit.Rideal          =  	287.053 ;                                   % Ideal Gas Constant                            [m^2/(K*s^2)]
    datUnit.P_sl         	=   101325 ;                                    % Pressure at Sea Level                         [Pa]
    datUnit.gamma        	=   1.4 ;                                       % Specific Heat Ratio                           [*]
    datUnit.Flattening      =   3.33528106e-3 ;                             % Flattening of the Earth                       [*]
    datUnit.Semi            =   6378137 ;                                   % semi-major axis of Earth's ellipsoid (WGS84)  [m]
    datUnit.Omega           =   0.0*7.2722e-5 ;                                 % angular rotation of earth                     [rad/s]
    datUnit.AGRAV           =   9.807;                                      % Standard Gravity                              [m/s^2]

%.. RLV Configuration

    datAero.Refa            =   10 ;                                        % Reference Area                            [m^2]
    datAero.CD              =   1.0 ;                                       % Drag Coeffcient                           [*]
    
%.. Fuel Consumption

    datThr.Isp              =   300 ;                                       % Specific Impulse                          [sec] 
    datThr.Aexit            =   0.5 ;                                       % exit area of nozzle                       [m^2]

    
%.. Thrust Bound

    % Original
    datThr.ThrustUpper = 2.5e+5;                                            % Thrust upper bound                       [N]
    datThr.ThrustLower = 1e+5;                                               % Thrust lower bound                       [N]
    
    % Change
    %datThr.ThrustUpper = 10e+5;                                              % Thrust upper bound                       [N]
    %datThr.ThrustLower = 1e+5;                                             % Thrust lower bound                       [N]
 
%.. Initial Conditions

    % Landing Point 
    datRlv.Pos_Geod         =   [ 34.43861 * datUnit.D2R ;                  % Landing Position in Geodetic Coordinate       
                                  127.53722* datUnit.D2R ; 
                                  107.00000 ] ;  
                              
    % Initial Conditions
    datRlv.Rbll0            =   [ 0 ; 500 ; -500.0 ] ;                     % Initial Body Position w.r.t. Landing Point(L) in L-Coord.
    
    datRlv.Vbll0            =   [ 50 ; 0 ; 50 ] ;                          % Initial Body Velocity. w.r.t. Landing Point(L) in L-Coord. 
    
    datRlv.Mass0            =   1.5e+4 ;                                   % Initial Body Mass 
    

    
    % Final Conditions 
    datRlv.Rbllf        	=   [ 0.0 ; 0.0 ; 0.0 ] ;                       % Final Body Position w.r.t. Landing Point(L) in L-Coord.                                         
    datRlv.Vbllf            =   [ 0.0 ; 0.0 ; 0.0 ] ;                       % Final Body Velocity w.r.t. Landing Point(L) in L-Coord. 
    

 


