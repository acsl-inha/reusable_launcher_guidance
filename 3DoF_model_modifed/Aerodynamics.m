%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Aerodynamics.m                                                %
%                                                                         %
%                               - Created by B. S. Kim, 2020. 07. 13.     %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global and Persistent Variables 

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim
    
%.. Importing Data

    cI_D        =   outDyn.cI_D ; 
    cD_V        =   outDyn.cD_V ; 

%.. Aerodynamic Module 

    % DCM From V-Coord. to I-Coord.
    cI_V        =   cD_V * cI_D ; 
    cV_I        =   cI_V' ; 

    % Aerodynamics Forces in V-Frame
    Fv_Aero     =   outEnv.DynPress * datAero.Refa * [ -datAero.CD ; 0.0 ; 0.0 ] ; 
    
    % Aerodynamics Forces in I-Frame 
    Fi_Aero     =   cV_I * Fv_Aero ; 
            
%.. Exporting Data

    %outAdy.Fi_Aero  =  	Fi_Aero ; 
    outAdy.Fi_Aero  =  	0 ; 
    
    