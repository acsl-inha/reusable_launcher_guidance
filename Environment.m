%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Environment.m                                                 %
%                                                                         %
%                           - Created by C. H. Lee, 2020. 02. 10.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global Variable

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim

%.. Importing Data

    Alt             =   outDyn.Pos_Geod(3,1) ; 
    V           	=   norm( outDyn.Vbed ) ; 
    
%.. Compute Environment Variables

    if  Alt < 11000                                                       	% Troposphere Case 
         
        T           = 	288.15 - 0.0065 * Alt ;                             % Temperature             	[K]
        Pressure    =  	datUnit.P_sl * ( T / 288.15 )^5.2559 ;              % Atmospheric Pressure  	[Pa]
        
    else                                                                 	% Stratosphere Case
        
        T           = 	216 ;                                               % Temperature               [K]
        Pressure    = 	22630 * exp( - 0.00015769 * ( Alt - 11000 ) ) ;     % Atmospheric Pressure   	[Pa]
        
    end
    
    Rho             = 	Pressure / ( datUnit.Rideal * T ) ;                      % Atmospheric Density   	[kg/m^3]
    V_sound         =  	sqrt( datUnit.gamma * datUnit.Rideal * T ) ;            	% Sonic Speed             	[m/s]
    Mach            =  	V / V_sound ;                                       % Mach Number               [*]                            
    Q               =  	0.5 * Rho * V^2 ;                                   % Dynamic Pressure        	[Pa]
    Grav            = 	datUnit.G * datUnit.E_mass/( datUnit.Rmean + Alt )^2 ;   % Gravitational Acc.        [m/s^2]           
    
%.. Exporting Data

    outEnv.Rho      =   Rho ; 
    outEnv.Vsound   =   V_sound ; 
    outEnv.DynPress =   Q ; 
    outEnv.Grav     =   Grav ; 
    outEnv.Mach     =   Mach ; 
    outEnv.Pressure =   Pressure ;      % Local air pressure
