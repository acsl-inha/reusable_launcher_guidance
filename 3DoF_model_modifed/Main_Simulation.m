%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Main_Simulation.m                                             %
%                                                                         %
%                               - Created by B. S. Kim, 2020. 07. 13.     %
%                               - Modified by C. H. Lee, 2020. 07. 19.    %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%


%.. Matlab Initialization 

    clc;        clear all ;         close all ; 
               
%.. Loading Files 

    Sim_Parameter ; 

%.. Model Initialization 

    Initialization ;  
    
%.. Main Loop    
    tic
    while(1)

        Environment ; 
        
        Aerodynamics ; 
        
        GCU ;
        if((datSim.tf == 0))
            break
        end
        
    	Thrust ; 
        
        Dynamics ; 
        if(outDyn.Rbll(3) >0)
            break
        end

    	SaveData ; 
        
        Integration; 
        
        disp(datSim.iRun)

                                
    end
    
    
    toc
    
%.. Plot 
    
     Sim_Plot ; 
 
