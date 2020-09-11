%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Modified_Euler.m                                          	  %
%                                                                         %
%                           - Created by C. H. Lee, 2019. 08. 13.         %
%                           - Modified by C. H. Lee, 2020. 07. 19.        %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function out = Modified_Euler( dydx_new, dydx, y, int_step )

    global datSim 
    
    if datSim.iRun == 1 

        out     =   y + dydx_new * int_step ; 
    
    else

        out      =  y + ( dydx_new+dydx)*int_step/2;

    end

end