function T_f_step = Find_timestep(N,multiplier,Check) 
    % Find the appropriate time
    if Check == 1
        T_f_step =  N + 2^multiplier;                                      % Add
    elseif Check == -1
        T_f_step = N - 2^multiplier;                                       % Subtrack
    end
    
end

