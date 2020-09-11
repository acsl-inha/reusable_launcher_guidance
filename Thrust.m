%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Thrust.m                                                      %
%                                                                         %
%                               - Created by C. H. Lee, 2020. 07. 19.     %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global Variables 

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim

%.. Importing Data

    Thr_Cmd   	=   outGCU.Thr_Cmd ; 
    cI_E        =   outDyn.cI_E ; 
    cE_L        =   outDyn.cE_L ; 

%.. Thrust Module 

    % DCM From L-Coord. to I-Coord.
    cI_L        =   cE_L * cI_E ; 
    cL_I        =   cI_L' ; 
    
    % Thrust in I-Frame 
    Fi_Thr      =   cL_I * Thr_Cmd ; 
            
%.. Exporting Data

    outThr.Fi_Thr =  	Fi_Thr ; 
