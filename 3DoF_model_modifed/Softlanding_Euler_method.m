
    clc;        clear all ;         close all ; 

Sim_Parameter;

%.. Global and Persistent Variables 
    global  datThr  datSim    datRlv    datUnit     outDyn
    
%.. Local Variables

    t_f                 =   datSim.tf;                                                                 % Final time
    delt                =   datSim.dt;                                                                 %
    N                   =   fix(t_f / delt);                                                           % Step size
    Alpha               =   1/( datThr.Isp * datUnit.AGRAV);                                            % Fuel consumption
    g_e                 =   datUnit.AGRAV;                                                             % Earth grvity
    r_0                 =   datRlv.Rbll0;                                                              % Initial position in L-Coord.
    v_0                 =   datRlv.Vbll0;                                                              % Initial velocity in L-Coord.
    r_f                 =   datRlv.Rbllf;                                                              % Final position in L-Coord.
    v_f                 =   datRlv.Vbllf;                                                              % Final velocity in L-Coord.
    Mass                =   datRlv.Mass0;

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
        %minimize (norm( Sigma_var,Inf))
        
        subject to
            r(:,1) == r_0
            v(:,1) == v_0
            r(:,end) == r_f
            v(:,end) == v_f
            
            for t = 1:N
                
                r(:,t+1) == r(:,t) + delt * (v(:,t))
                v(:,t+1) == v(:,t) + delt * (u(:,t)+ [0;0;-g_e])
                
                
                z(t+1) == z(t) - Alpha * delt * (Sigma_var(t))
                norm( u(:,t) ) <= Sigma_var(t)
                Mu1(t) * ( 1 - ( z(t) - z_0(t) )) <= Sigma_var(t)
                Sigma_var(t) <= Mu2(t) * (1 - ( z(t) - z_0(t) ))
                z_0(t) <= z(t)
                z(t) <= log( Mass - Alpha * datThr.ThrustLower * (t-1) * delt)
                r(3,t) <= 0
                
            end

            norm(u(:,end)) <= Sigma_var(end)
            Mu1(end) * ( 1 - (z(end) -z_0(end))) <= Sigma_var(end)
            Sigma_var(:,end) <= Mu2(end) * (1 - (z(end) - z_0(end)))
            z_0(end) <= z(end)
            z(end) <= log(Mass - Alpha * datThr.ThrustLower * N * delt)
            r(3,t) <= 0

    cvx_end
    
    
    
    
for i = 1:N+1
    Thrust(:,i) = u(:,i) * exp(z(i));
end


%% plotting

    x = 0:delt:t_f;

    
    figure(1)
    subplot(3,1,1)
    plot(x,Thrust(1,:))
    grid on ; hold on;
    title('Thrust', 'FontSize', 12)
    subplot(3,1,2)
    plot(x,Thrust(2,:))
    grid on ; hold on; 
    subplot(3,1,3)
    plot(x,Thrust(3,:))
    grid on ; hold on; 

    figure(2)
    subplot(3,1,1)
    plot(x,r(1,:))
    grid on ; hold on;
    title('Position', 'FontSize', 12)
    subplot(3,1,2)
    plot(x,r(2,:))
    grid on ; hold on; 
    subplot(3,1,3)
    plot(x,r(3,:))
    grid on ; hold on; 
     


%% test

r_T = transpose(r);
v_T = transpose(v);