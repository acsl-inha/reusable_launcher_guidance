%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Sim_Plot.m                                                    %
%                                                                         %
%                               - Created by B. S. Kim, 2020. 07. 13.     %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global Variables 

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim
    
%.. Plotting

    figure(1)  
    plot( outSim.Time(:,1), outSim.Mass(:,1), 'b', 'linewidth', 1.5 )
    xlabel('Time (sec)')
    ylabel('Mass (kg)')
    grid on ; hold on; 
    title('Mass (kg)', 'FontSize', 12)

    figure(2)  
    subplot(3,1,1)  
    plot( outSim.Time(:,1), outSim.X_I(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('X_I(m)')
    grid on ; hold on; 
    title('Position (ECI)', 'FontSize', 12)
    subplot(3,1,2)  
    plot( outSim.Time(:,1), outSim.Y_I(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('Y_I(m)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( outSim.Time(:,1), outSim.Z_I(:,1), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Z_I(m)')
    grid on ; hold on; 

    figure(3)  
    subplot(3,1,1)  
    plot( outSim.Time(:,1), outSim.Vx_I(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('V_X(m/s)')
    title( 'Velocity (ECI)', 'FontSize', 12 )
    grid on ; hold on; 
    subplot(3,1,2)  
    plot( outSim.Time(:,1), outSim.Vy_I(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('V_Y(m/s)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( outSim.Time(:,1), outSim.Vz_I(:,1), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('V_Z(m/s)')
    grid on ; hold on; 

    figure(4)  
    subplot(3,1,1)  
    plot( outSim.Time(:,1), outSim.lat_d(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('lati (deg)')
    title( 'Position (Geodetic)', 'FontSize', 12 )
    grid on ; hold on; 
    subplot(3,1,2)  
    plot( outSim.Time(:,1), outSim.long_d(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('longi (deg)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( outSim.Time(:,1), outSim.alt_d(:,1), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Altitude (m)')
    grid on ; hold on; 

    figure(5)  
    subplot(3,1,1)  
    plot( outSim.Time(:,1), outSim.X_E(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('X_E(m)')
    grid on ; hold on; 
    title('Position (ECEF)', 'FontSize', 12)
    subplot(3,1,2)  
    plot( outSim.Time(:,1), outSim.Y_E(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('Y_E(m)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( outSim.Time(:,1), outSim.Z_E(:,1), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Z_E(m)')
    grid on ; hold on; 

    figure(6)
    subplot(3,1,1)
    plot( outSim.Time(:,1), outSim.flightpath(:,1), 'b', 'linewidth', 1.5 )
    ylabel('\gamma(deg)')
    grid on ; hold on ;
    title('Velocity (FPA)', 'FontSize', 12 )
    subplot(3,1,2)
    plot( outSim.Time(:,1), outSim.heading(:,1), 'b', 'linewidth', 1.5 )
    ylabel('\chi(deg)')
    grid on ; hold on ;
    subplot(3,1,3)
    plot( outSim.Time(:,1), outSim.magV(:,1), 'b', 'linewidth', 1.5 )
    xlabel('Time (sec)')
    ylabel('magV(m/s)')
    grid on ; hold on ;

    figure(7)  
    subplot(3,1,1)  
    plot( outSim.Time(:,1), outSim.lat_c(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('lati (deg)')
    title( 'Position (Geocentric)', 'FontSize', 12 )
    grid on ; hold on; 
    subplot(3,1,2)  
    plot( outSim.Time(:,1), outSim.long_c(:,1), 'b', 'linewidth', 1.5 ) 
    ylabel('longi (deg)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( outSim.Time(:,1), outSim.alt_c(:,1), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Altitude (m)')
    grid on ; hold on; 
    
    figure(8)  
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

    figure(9)  
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









 
