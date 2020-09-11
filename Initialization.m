%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Initialization.m                                              %
%   - Initialize Position and Velocity, and Modules.                      %
%                                                                         %
%                               - Created by B. S. Kim, 2020. 07. 15.     %
%                               - Modified by C. H. Lee, 2020. 07. 19.    %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global Variables

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim
    
%.. Initial Time

    datSim.Time       	=   0.0 ; 

%.. Initial Inertial Position 

	Rlie0               =   CnvPos_D2E( datRlv.Pos_Geod ) ;                 % Landing Position w.r.t Earth Center in E-Coord.  
    cE_L0               =   GetDCM_E2D( datRlv.Pos_Geod ) ;              	% DCM from E-Coord to L-Coord.
    cL_E0               =   cE_L0' ;                                        % DCM from L-Coord to E-Coord.
    Rble0               =   cL_E0 * datRlv.Rbll0 ;                          % Body Position w.r.t. Landing Point in E-Coord.
    Rbie0               =   Rlie0 + Rble0 ;                                 % Body Position w.r.t. Earth Center in E-Coord.
	cI_E0               =   GetDCM_I2E( datUnit.Omega * datSim.Time );      % DCM from I-Coord. to E-Coord.
	cE_I0               =   cI_E0' ;                                        % DCM from E-Coord. to I-Coord.
    Rbii0               =   cE_I0 * Rbie0 ;                                 % Body Inertial Position in I-Coord.

%.. Initial Inertial Velocity

	Vble0               =   cL_E0 * datRlv.Vbll0 ;                          % Body Velocity w.r.t. Landing Point in E-Coord.
    Vbli0               =   cE_I0 * Vble0 ;                               	% Body Velocity w.r.t. Landing Point in I-Coord.
    Wlii                =   [ 0.0 ; 0.0 ; datUnit.Omega ] ;                 % Landing Point Angular Velocity w.r.t. I-Frame Expressed in I-Coord. 
    Vbii0               =   Vbli0 + cross( Wlii, Rbii0 )  ;                 % Body Inertial Velocity in I-Coord.

%.. Initial Body Position and Velocity in ECEF

    Rbie0               =   cI_E0 * Rbii0 ;                                 % Body Position w.r.t. Earth Center in E-Coord. 
    Vbie0               =   cI_E0 * Vbii0 ;                                 % Body Velocity w.r.t. Earth Center in E-Coord.  

%.. Initial Geocentric and Geodetic Positions 

    Pos_Geoc0           =   CnvPos_E2C( Rbie0 ) ;                           % Body Position in C-Coords. 
    Pos_Geod0           =   CnvPos_E2D( Rbie0 ) ;                           % Body Position in D-Coords. 
    
%.. Initial DCM from E- Coord. to D-Coord. 
    
    cE_D0               =   GetDCM_E2D( Pos_Geod0 ) ;                       % DCM from E-Coord. to D-Coord.
    
%.. Initial Body Geographic Velocity (w.r.t. Earth) 

    Weii                =   [ 0.0 ; 0.0 ; datUnit.Omega ] ;                 % Earth Angular Velocity w.r.t. I-Frame in I-Coord. 
    Vbei0               =   Vbii0 - cross( Weii, Rbii0 ) ;                  % Body Velocity w.r.t. Earth (any point on Earth) in I-Coord. 
    cI_D0               =   cE_D0 * cI_E0 ;                                 % DCM from I-Coord. to D-Coord. 
    Vbed0               =   cI_D0 * Vbei0 ;                                 % Body Velocity w.r.t. Earth in D-Coord.

%.. Initial Velocity Angles from Geographic Velocity 

    angVbed0            =   GetAngle( Vbed0 ) ;                             % Heading and Flight Path Angles 

%.. Initial DCM from Geodetic to Velocity Coordinate

    cD_V0               =   GetAng2DCM( angVbed0 ) ; 

%.. Model Initialization 

    % OutSim Module      
	outSim              =   [ ] ; 
    
    % Environment Module 
    outEnv              =   [ ] ; 
    
    % Aerodynamic Module
    outAdy              =   [ ] ; 
    
    % GCU Module 
    outGCU              =   [ ] ; 
    
    % Thrust Module 
    outThr              =   [ ]; 
   
    % Dynamics Module 
    outDyn.Mass         =   datRlv.Mass0 ;
    outDyn.Rbii         =   Rbii0 ; 
    outDyn.Vbii         =   Vbii0 ; 
    outDyn.Abii         =   zeros(3,1) ; 
    outDyn.Rbie         =   Rbie0 ; 
    outDyn.Vbie         =   Vbie0 ; 
    outDyn.Rlie         =   Rlie0 ; 
    outDyn.Rbll         =   datRlv.Rbll0 ;
    outDyn.Vbll         =   datRlv.Vbll0 ; 
    outDyn.Vbed         =   Vbed0 ; 
    outDyn.cD_V         =   cD_V0 ; 
    outDyn.cI_D         =   cI_D0 ; 
    outDyn.cE_L         =   cE_L0 ;  
    outDyn.cI_E         =   cI_E0 ; 
    outDyn.angVbed      =   angVbed0 ; 
    outDyn.Pos_Geoc     =   Pos_Geoc0 ; 
    outDyn.Pos_Geod     =   Pos_Geod0 ; 
 	outDyn.magVbe       =   norm( Vbed0 ) ; 
    outDyn.dot_Rbii     =   zeros(3,1) ; 
    outDyn.dot_Vbii     =   zeros(3,1) ; 
    outDyn.dot_Mass     =   0.0 ; 
    outDyn.dot_Rbii_prev=   zeros(3,1) ; 
    outDyn.dot_Vbii_prev=   zeros(3,1) ; 
    outDyn.dot_Mass_prev=   0.0 ; 