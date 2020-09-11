   clc;        clear all ;         close all ; 
   
   
                  
%.. Loading Files 

    Sim_Parameter ; 

%.. Model Initialization 

    Initialization ;  
%.. Global and Persistent Variables 

    global  datThr  datSim    datRlv    datUnit
    global  outDyn
    
%.. Local Variables

    t_f             =           datSim.tf ;                      % Remaining time
    delt            =           datSim.dt;                                 
    N               =           t_f/delt;
    Alpha           =           1/( datThr.Isp * datUnit.AGRAV);
    Mass            =           outDyn.Mass;
    g               =           datUnit.AGRAV;
    
    for t = 1:N+1
        z_0(t) = log(Mass - Alpha * datThr.ThrustUpper * (t-1) * delt);
        Mu1(t) = datThr.ThrustLower * exp(-z_0(t));
        Mu2(t) = datThr.ThrustUpper * exp(-z_0(t));
    end

 %.. compute cvx    
    cvx_begin
        
        variable u(3,N+1)
        variable r(3,N+1)
        variable v(3,N+1)
        variable Sigma_var(N+1)
        variable z(N+1)
     
        minimize ( -z(end))
        
        subject to
        
            r(:,1) ==  datRlv.Rbll0
            v(:,1) ==  datRlv.Vbll0
            r(3,end) == 0
            v(:,end) == datRlv.Vbllf
            
            for t = 1:N
                r(:,t+1) == r(:,t) + delt * (v(:,t))
                v(:,t+1) == v(:,t) + delt * (u(:,t)+ [0;0;-g])
                z(t+1) == z(t) - Alpha * delt * (Sigma_var(t))
                norm( u(:,t) ) <= Sigma_var(t)
                Mu1(t) * ( 1 - ( z(t) - z_0(t) ))  <=  Sigma_var(t)
                Sigma_var(t) <= Mu2(t) * (1 - ( z(t) - z_0(t) ))
                z_0(t) <= z(t)
                z(t) <= log( Mass - Alpha * datThr.ThrustLower * (t-1) * delt)
                
                %r(3,t) <= 0
            end

            norm(u(:,end)) <= Sigma_var(end)
            Mu1(end) * ( 1 - (z(end) - z_0(end))) <= Sigma_var(end)
            Sigma_var(:,end) <= Mu2(end) * (1 - (z(end) - z_0(end)))
            z_0(end) <= z(end)
            z(end) <= log(Mass - Alpha * datThr.ThrustLower * N * delt)
            
            r(3,end) <= 0

    cvx_end
    
    
    %% Thrust value
    
    for i = 1:N+1
        
        Thrust_x(i) = u(1,i) *exp(z(i));
        Thrust_y(i) = u(2,i) *exp(z(i));
        Thrust_z(i) = u(3,i) *exp(z(i));
        k = [Thrust_x(i);Thrust_y(i);Thrust_z(i)];
        Thrust_norm(i) = norm(k);
    
    end
    
    %% plotting
    
    figure(1)  
    subplot(3,1,1)  
    plot( Thrust_x(:), 'b', 'linewidth', 1.5 ) 
    ylabel('Vx_L(m/s)')
    title( 'thrust', 'FontSize', 12 )
    grid on ; hold on; 
    subplot(3,1,2)  
    plot( Thrust_y(:), 'b', 'linewidth', 1.5 ) 
    ylabel('Vy_L(m/s)')
    grid on ; hold on; 
    subplot(3,1,3) 
    plot( Thrust_z(:), 'b', 'linewidth', 1.5 ) 
    xlabel('Time (sec)')
    ylabel('Vz_L(m/s)')
    grid on ; hold on;     

    
    
    