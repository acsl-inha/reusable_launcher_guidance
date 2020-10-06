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
    
<<<<<<< HEAD
    
    toc
=======
    toc
    
>>>>>>> master
    
%.. Plot 
    
     Sim_Plot ; 

     %% plotting
    
    figure(10)
    subplot(3,1,1)
    plot(outSim.Time(:,1),outSim.Thr_x_L(:,1))
    ylabel('N')
    title('Thrust in L-coor', 'FontSize', 12)
    subplot(3,1,2)
    plot(outSim.Time(:,1),outSim.Thr_y_L(:,1))
    ylabel('E')
    subplot(3,1,3)
    plot(outSim.Time(:,1),outSim.Thr_z_L(:,1))
    xlabel('Time (sec)')
    ylabel('D')
    

    figure(11)  
    plot( outSim.Time(:,1), outSim.Thr_L_norm(:,1), 'b', 'linewidth', 1.5 )
    xlabel('Time (sec)')
    ylabel('Thrust norm')
    title( 'Thrust norm L-frame', 'FontSize', 12 )
    ylim([0 0.5e+6])
    grid on ; hold on;     

    figure(12)  
    plot( outSim.Time(:,1), outSim.Vx_L(:,1), 'r', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Velocity(m/s)')
    title( 'Velocity in Landing Frame', 'FontSize', 12 )
    hold on; 
    plot( outSim.Time(:,1), outSim.Vy_L(:,1), 'b', 'linewidth', 1.5 ) 
    hold on; 
    plot( outSim.Time(:,1), outSim.Vz_L(:,1), 'k', 'linewidth', 1.5 ) 
    grid on ; hold on;     
    legend('X_L','Y_L','Z_L')
    lgd = legend;
    lgd.FontSize = 7;
    
    
    figure(13)  
    plot( outSim.Time(:,1), outSim.X_L(:,1), 'r', 'linewidth', 1.5 ) 
    grid on ; hold on; 
    title('Position in Landing Frame', 'FontSize', 12)
    plot( outSim.Time(:,1), outSim.Y_L(:,1), 'b', 'linewidth', 1.5 ) 
    grid on ; hold on; 
    plot( outSim.Time(:,1), outSim.Z_L(:,1), 'k', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Position(m)')
    grid on ; hold on; 
    legend('X_L','Y_L','Z_L')
    lgd = legend;
    lgd.FontSize = 7;
    
    
    