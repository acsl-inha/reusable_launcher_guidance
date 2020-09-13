function T_f_step = Find_timestep(multiplier,Check)
    %.. Global and Persistent Variables 
    global      datSim
    
    % Find the appropriate time
    if Check == 1
        T_f_step =  fix(datSim.tf/datSim.dt) + 2^multiplier;
    elseif Check == -1
        T_f_step = fix(datSim.tf/datSim.dt) - 2^multiplier;
    end
    
end

