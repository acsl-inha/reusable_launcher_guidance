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

    cvx_solver SDPT3
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

     %% plotting
    
    figure(10)
    set(gcf,'position',[100,100,800,400])
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
    set(gcf,'position',[100,100,800,400])
    plot( outSim.Time(:,1), outSim.Thr_L_norm(:,1), 'b', 'linewidth', 1.5 )
    xlabel('Time (sec)')
    ylabel('Thrust norm')
    title( 'Thrust norm L-frame', 'FontSize', 12 )
    ylim([0 0.5e+6])
    grid on ; hold on;     

    figure(12)
    set(gcf,'position',[100,100,800,400])
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
    set(gcf,'position',[100,100,800,400])
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
  
    figure(14)  
    set(gcf,'position',[100,100,800,400])
    plot( outSim.Time(:,1), outSim.Thr_Aero_norm(:,1), 'b', 'linewidth', 1.5 )
    xlabel('Time (sec)')
    ylabel('Aero norm')
    title( 'Aero norm L-frame', 'FontSize', 12 )
    ylim([0 0.5e+6])
    grid on ; hold on;     
    %%
    
    figure(13)
    subplot(2,1,1)
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
    lgd.FontSize = 5;
    
    subplot(2,1,2)
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
    lgd.FontSize = 5;
    saveas(gcf,'picture.png')
    
    %%
    k = plot3(outSim.X_L(:,1),outSim.Y_L(:,1),-outSim.Z_L(:,1),'DisplayName', 'Flighat trajectory');
    k.LineWidth = 2;
    hold on;
    scatter3(outSim.X_L(1,1),outSim.Y_L(1,1),-outSim.Z_L(1,1),'filled','DisplayName','Initial position');
    scatter3(outSim.X_L(end,1),outSim.Y_L(end,1),-outSim.Z_L(end,1),'filled','DisplayName', 'Final position');
    xlabel('N[m]')
    ylabel('E[m]')
    zlabel('U[m]')
    xlim([0 600])
    ylim([0 600])
    zlim([0 600])
    view(50,24);
    grid on;
    legend();
    
    