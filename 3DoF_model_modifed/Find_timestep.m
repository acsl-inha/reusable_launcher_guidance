function T_f_step = Find_timestep(N_step,multiplier,Check) 
    % Add or Subtract timestep 
    if Check == 1
        T_f_step =  N_step + 2^multiplier;                                 % Add
    elseif Check == -1
        T_f_step = N_step - 2^multiplier;                                  % Subtract
    end
end

