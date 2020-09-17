function Result = Verify_Infeasible(Position,Velocity,N_step)
        [N,E,D]         = 	 Compute_cvx_Euler(Position,Velocity,N_step);
        Thr_Cmd         =    [N;E;D];
        Check = isnan(Thr_Cmd);
        if(Check ==[1;1;1]) 
            Result = 0;                                                    % Infeasible
        else
            Result = Thr_Cmd;                                                    % Feasible
        end
end
