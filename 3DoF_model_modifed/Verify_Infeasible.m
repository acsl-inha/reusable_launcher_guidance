function Result = Verify_Infeasible(Position,Velocity,N_step)
        % If result is infeasible --> Result is  0 
        % If result is feasible   --> Result is  Thrust
        [N,E,D]         = 	 Compute_cvx_Euler(Position,Velocity,N_step);
        Thr_Cmd         =    [N;E;D];
        Check = isnan(Thr_Cmd);
        if(Check ==[1;1;1]) 
            Result = 0;                                                    % Infeasible
        else
            Result = Thr_Cmd;                                              % Feasible
        end
end
