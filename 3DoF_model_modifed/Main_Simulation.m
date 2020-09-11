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
    
    for i = 1 : datSim.nStep
    %for i = 1 : datSim.nStep+50
        

        Environment ; 
        
        Aerodynamics ; 
        
        GCU ;
        
        Check = isnan(Thr_Cmd);
        if(Check ==[1;1;1])
            break
        end
        
    	Thrust ; 
        
        Dynamics ; 

    	SaveData ; 
        
        Integration; 
        
        datSim.iRun
                                
    end
    
    
    
    
    
%.. Plot 
    
%     Sim_Plot ; 
%     
    
%% test

    
     %% plotting
    
    figure(1)
    subplot(3,1,1)
    plot(outSim.Time(:,1),outSim.Thr_x_Aero(:,1))
    ylabel('N')
    grid on ; hold on; 
    title('Aero', 'FontSize', 12)
    subplot(3,1,2)
    plot(outSim.Time(:,1),outSim.Thr_y_Aero(:,1))
    ylabel('E')
    grid on ; hold on; 
    subplot(3,1,3)
    plot(outSim.Time(:,1),outSim.Thr_z_Aero(:,1))
    ylabel('D')
    grid on ; hold on; 
    
    figure(2)
    subplot(3,1,1)
    plot(outSim.Time(:,1),outSim.Thr_x_I(:,1))
    ylabel('N')
    title('Thrust in I-coor', 'FontSize', 12)
    subplot(3,1,2)
    plot(outSim.Time(:,1),outSim.Thr_y_I(:,1))
    ylabel('E')
    subplot(3,1,3)
    plot(outSim.Time(:,1),outSim.Thr_z_I(:,1))
    ylabel('D')
    
    
    figure(3)
    subplot(3,1,1)
    plot(outSim.Time(:,1),outSim.Thr_x_L(:,1))
    ylabel('N')
    title('Thrust in L-coor', 'FontSize', 12)
    subplot(3,1,2)
    plot(outSim.Time(:,1),outSim.Thr_y_L(:,1))
    ylabel('E')
    subplot(3,1,3)
    plot(outSim.Time(:,1),outSim.Thr_z_L(:,1))
    ylabel('D')
    
    figure(4)  
    subplot(3,1,1)  
    plot( outSim.Time(:,1), outSim.X_L(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('X_L(m)')
    grid on ; hold on; 
    title('Position in Landing Frame', 'FontSize', 12)
    subplot(3,1,2)  
    plot( outSim.Time(:,1), outSim.Y_L(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('Y_L(m)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( outSim.Time(:,1), outSim.Z_L(:,1), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Z_L(m)')
    grid on ; hold on; 
    
        
    figure(5)  
    subplot(3,1,1)  
    plot( outSim.Time(:,1), outSim.Fitot_x(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('X_L(m)')
    grid on ; hold on; 
    title('Fi_total', 'FontSize', 12)
    subplot(3,1,2)  
    plot( outSim.Time(:,1), outSim.Fitot_y(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('Y_L(m)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( outSim.Time(:,1), outSim.Fitot_z(:,1), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Z_L(m)')
    grid on ; hold on; 
    
    
    
    figure(6)  
    subplot(3,1,1)  
    plot( outSim.Time(:,1), outSim.Vx_L(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('Vx_L(m/s)')
    title( 'Velocity in Landing Frame', 'FontSize', 12 )
    grid on ; hold on; 
    subplot(3,1,2)  
    plot( outSim.Time(:,1), outSim.Vy_L(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('Vy_L(m/s)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( outSim.Time(:,1), outSim.Vz_L(:,1), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Vz_L(m/s)')
    grid on ; hold on;     
    
    


