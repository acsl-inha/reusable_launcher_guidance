function Result = Check_Infeasible(Position,Velocity,N)

        [N,E,D]         = 	 Compute_cvx_Euler(Position,Velocity,N);
        Thr_Cmd         =    [N;E;D];
        Check = isnan(Thr_Cmd);
        if(Check ==[1;1;1]) 
            Result = 0;                                                    % Infeasible
        else
            Result = 1;                                                    % Feasible
        end
end

