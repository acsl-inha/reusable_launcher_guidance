    global  datThr  datSim    datRlv    datUnit
    global  outDyn

    %.. Loading Files 

    Sim_Parameter ; 

    %.. Model Initialization 

    Initialization ;  
    
    
    
    
%.. Local Variables

    delt                =   datSim.dt;                                            % dt
    Alpha               =   1/( datThr.Isp * datUnit.AGRAV);                      % Fuel consumption
    g_e                 =   datUnit.AGRAV;                                        % Earth grvity
    r_0                 =   datRlv.Rbll0;                                             % Initial position in L-Coord.
    v_0                 =   datRlv.Vbll0;                                             % Initial velocity in L-Coord.
    r_f                 =   datRlv.Rbllf;                                         % Final position in L-Coord.
    v_f                 =   datRlv.Vbllf;                                         % Final velocity in L-Coord.
    Mass                =   outDyn.Mass;
    N_step              =   fix(datSim.tf/delt);
    
    for t = 1:N_step+1
        z_0(t) = log(Mass - Alpha * datThr.ThrustUpper * (t-1) * delt);
        Mu1(t) = datThr.ThrustLower * exp(-z_0(t));
        Mu2(t) = datThr.ThrustUpper * exp(-z_0(t));
    end
    
 %.. compute cvx    
    cvx_begin
        
        variable u(3,N_step+1)
        variable r(3,N_step+1)
        variable v(3,N_step+1)
        variable Sigma_var(N_step+1)
        variable z(N_step+1)
     
        %minimize ( -z(end))
        minimize ( sum_square(Sigma_var))
        
        subject to
            r(:,1) == r_0
            v(:,1) == v_0
            r(:,end) == r_f
            v(:,end) == v_f
            
            for t = 1:N_step
                
                r(:,t+1) == r(:,t) + delt * (v(:,t))
                v(:,t+1) == v(:,t) + delt * (u(:,t)+ [0;0;g_e])
                z(t+1) == z(t) - Alpha * delt * (Sigma_var(t))
                norm( u(:,t) ) <= Sigma_var(t)
                Mu1(t) * ( 1 - ( z(t) - z_0(t) )) <= Sigma_var(t)
                Sigma_var(t) <= Mu2(t) * (1 - ( z(t) - z_0(t) ))
                z_0(t) <= z(t)
                z(t) <= log( Mass - Alpha * datThr.ThrustLower * (t-1) * delt)

                
            end

            norm(u(:,end)) <= Sigma_var(end)
            Mu1(end) * ( 1 - (z(end) -z_0(end))) <= Sigma_var(end)
            Sigma_var(:,end) <= Mu2(end) * (1 - (z(end) - z_0(end)))
            z_0(end) <= z(end)
            z(end) <= log(Mass - Alpha * datThr.ThrustLower * N_step * delt)

    cvx_end
    
    
    for t = 1:N_step
    test_N(t) = u(1,t) .* exp(z(t));
    test_E(t) = u(2,t) .* exp(z(t));
    test_D(t) = u(3,t) .* exp(z(t));
    test_norm(t) = norm([test_N(t);test_E(t);test_D(t)]);
    end
    

    %%
    figure(50)  
    plot( test_norm(:), 'b', 'linewidth', 1.5 )
    xlabel('Time (sec)')
    ylabel('Thrust norm')
    title( 'Thrust norm L-frame', 'FontSize', 12 )
    grid on ; hold on;     

%%
%%
cvx_solver
