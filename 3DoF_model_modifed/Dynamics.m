%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Dynamics.m                                                    %
%                                                                         %
%                               - Created by B. S. Kim, 2020. 07. 15.     %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global and Persistent Variables 

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim
    
%.. Importing Data

    Fi_Aero         =       outAdy.Fi_Aero ; 
    Fi_Thr          =       outThr.Fi_Thr ;
    Rbii            =       outDyn.Rbii ; 
    Vbii            =       outDyn.Vbii ; 
    Mass            =       outDyn.Mass ; 
    cE_L            =       outDyn.cE_L ; 
    Rlie            =       outDyn.Rlie ; 

%.. Dynamic Module

    % Total Force
    Fi_tot          =       Fi_Aero + Fi_Thr ; 
    
    % Specific Force 
    Abii            =       Fi_tot / Mass ; 
       
    % Gravity Acceleration in ECI
    Gravi           =       - datUnit.G * datUnit.E_mass * Rbii / ( norm( Rbii ) )^3 ; 
   
    % Dynamics 
    dot_Rbii        =       Vbii ; 
    dot_Vbii        =       Abii + Gravi ;     
    dot_Mass        =       - norm( Fi_Thr ) / ( datThr.Isp * datUnit.AGRAV ) - ( outEnv.Pressure * datThr.Aexit ) / ( datThr.Isp * datUnit.AGRAV ) ;           
    
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
    
%.. Exporting Module
    
	outDyn.Mass         =   Mass ;
    outDyn.Rbii         =   Rbii ; 
    outDyn.Vbii         =   Vbii ; 
    outDyn.Abii         =   Abii ; 
    outDyn.Rbie         =   Rbie ; 
    outDyn.Vbie         =   Vbie ; 
    outDyn.Vbed         =   Vbed ; 
    outDyn.cD_V         =   cD_V ; 
    outDyn.cI_D         =   cI_D ; 
    outDyn.cI_E         =   cI_E ; 
    outDyn.Rbll         =   Rbll ; 
    outDyn.Vbll         =   Vbll ; 
    outDyn.angVbed      =   angVbed ; 
    outDyn.Pos_Geoc     =   Pos_Geoc ; 
    outDyn.Pos_Geod     =   Pos_Geod ; 
    outDyn.magVbe       =   norm( Vbed ) ; 
    
    outDyn.dot_Rbii     =   dot_Rbii; 
    outDyn.dot_Vbii     =   dot_Vbii ; 
    outDyn.dot_Mass     =   dot_Mass ; 
    
    outDyn.Fi_tot       =   Fi_tot;
