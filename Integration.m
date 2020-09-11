%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Integration.m                                              	  %
%                                                                         %
%                               - Created by C. H. Lee, 2020. 07. 19.     %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global and Persistent Variables 

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim
    
%.. Importing Data

    Rbii            =       outDyn.Rbii ; 
    Vbii            =       outDyn.Vbii ; 
    Mass            =       outDyn.Mass ; 

    dot_Rbii_new    =       outDyn.dot_Rbii ; 
    dot_Vbii_new    =       outDyn.dot_Vbii ;
    dot_Mass_new    =       outDyn.dot_Mass ; 
    
    dot_Rbii_prev   =       outDyn.dot_Rbii_prev ; 
    dot_Vbii_prev   =       outDyn.dot_Vbii_prev ; 
    dot_Mass_prev   =       outDyn.dot_Mass_prev ; 
    
%.. Integration Module 

    Rbii           	=       Modified_Euler( dot_Rbii_new, dot_Rbii_prev, Rbii, datSim.dt ) ; 
    dot_Rbii_prev   =       dot_Rbii_new ;

    Vbii            =       Modified_Euler( dot_Vbii_new, dot_Vbii_prev, Vbii, datSim.dt ) ; 
    dot_Vbii_prev   =       dot_Vbii_new ; 
    
    Mass            =       Modified_Euler( dot_Mass_new, dot_Mass_prev, Mass, datSim.dt ) ; 
    dot_Mass_prev   =       dot_Mass_new ; 

    datSim.Time     =       datSim.Time + datSim.dt ; 

%.. Exporting Module 

    outDyn.Rbii             =   Rbii ; 
    outDyn.Vbii             =   Vbii ; 
    outDyn.Mass             =   Mass ; 
    
    outDyn.dot_Rbii_prev    =   dot_Rbii_prev ; 
    outDyn.dot_Vbii_prev    =   dot_Vbii_prev ; 
    outDyn.dot_Mass_prev    =   dot_Mass_prev ; 