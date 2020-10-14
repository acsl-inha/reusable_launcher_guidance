%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: SaveData.m                                                    %
%                                                                         %
%                               - Created by B. S. Kim, 2020. 07. 15.     %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global Variables 

%.. Global and Persistent Variables 

    global      datSim      datUnit     datAero     datThr      datRlv        
    global      outEnv      outAdy      outGCU      outThr      outDyn      outSim
    
%.. Save Data 

    datSim.iRun             =       datSim.iRun + 1 ; 
    i                       =       datSim.iRun ; 
    
    outSim.Time(i,1)        =       datSim.Time ; 
	outSim.Mass(i,1)        =       outDyn.Mass ; 
	outSim.X_I(i,1)         =       outDyn.Rbii(1,1) ; 
	outSim.Y_I(i,1)         =       outDyn.Rbii(2,1) ; 
	outSim.Z_I(i,1)         =       outDyn.Rbii(3,1) ; 
	outSim.Vx_I(i,1)        =       outDyn.Vbii(1,1) ; 
	outSim.Vy_I(i,1)        =       outDyn.Vbii(2,1) ; 
	outSim.Vz_I(i,1)        =       outDyn.Vbii(3,1) ;
    outSim.magV(i,1)        =       outDyn.magVbe ;    
    outSim.X_E(i,1)         =       outDyn.Rbie(1,1) ;
    outSim.Y_E(i,1)         =       outDyn.Rbie(2,1) ;
    outSim.Z_E(i,1)         =       outDyn.Rbie(3,1) ;
    outSim.lat_c(i,1)       =       outDyn.Pos_Geoc(1,1) * datUnit.R2D ;
    outSim.long_c(i,1)      =       outDyn.Pos_Geoc(2,1) * datUnit.R2D ;
    outSim.alt_c(i,1)       =       outDyn.Pos_Geoc(3,1) ;
    outSim.lat_d(i,1)       =       outDyn.Pos_Geod(1,1) * datUnit.R2D ;
    outSim.long_d(i,1)      =       outDyn.Pos_Geod(2,1) * datUnit.R2D ;
    outSim.alt_d(i,1)       =       outDyn.Pos_Geod(3,1) ;
    outSim.flightpath(i,1)  =       outDyn.angVbed(2,1) * datUnit.R2D ;
    outSim.heading(i,1)     =       outDyn.angVbed(1,1) * datUnit.R2D ;
    outSim.X_L(i,1)         =       outDyn.Rbll(1,1) ; 
    outSim.Y_L(i,1)         =       outDyn.Rbll(2,1) ; 
    outSim.Z_L(i,1)         =       outDyn.Rbll(3,1) ; 
    outSim.Vx_L(i,1)        =       outDyn.Vbll(1,1) ; 
    outSim.Vy_L(i,1)        =       outDyn.Vbll(2,1) ; 
    outSim.Vz_L(i,1)        =       outDyn.Vbll(3,1) ; 
    
    
    %% Thrust
    outSim.Thr_x_Aero(i,1)     =       outAdy.Fi_Aero(1,1);
    outSim.Thr_y_Aero(i,1)     =       outAdy.Fi_Aero(2,1);
    outSim.Thr_z_Aero(i,1)     =       outAdy.Fi_Aero(3,1);
    
    Aero_norm                  =       norm([outAdy.Fi_Aero(1,1);outAdy.Fi_Aero(2,1);outAdy.Fi_Aero(3,1)]);
    outSim.Thr_Aero_norm(i,1)  =       Aero_norm;
    
    outSim.Thr_x_I(i,1)        =       outThr.Fi_Thr(1,1);
    outSim.Thr_y_I(i,1)        =       outThr.Fi_Thr(2,1);
    outSim.Thr_z_I(i,1)        =       outThr.Fi_Thr(3,1);
    
    Thr_I_norm                 =       norm([outThr.Fi_Thr(1,1);outThr.Fi_Thr(2,1);outThr.Fi_Thr(3,1)]);
    outSim.Thr_l_norm(i,1)     =       Thr_I_norm;
    
    outSim.Thr_x_L(i,1)        =       outGCU.Thr_Cmd(1);
    outSim.Thr_y_L(i,1)        =       outGCU.Thr_Cmd(2);
    outSim.Thr_z_L(i,1)        =       outGCU.Thr_Cmd(3);
    
    Thr_L_norm                 =       norm([outGCU.Thr_Cmd(1);outGCU.Thr_Cmd(2);outGCU.Thr_Cmd(3)]);
    outSim.Thr_L_norm(i,1)     =       Thr_L_norm;
    
    outSim.Fitot_x(i,1)        =       outDyn.Fi_tot(1,1);
    outSim.Fitot_y(i,1)        =       outDyn.Fi_tot(2,1);
    outSim.Fitot_z(i,1)        =       outDyn.Fi_tot(3,1);
    
    Fitot_norm                 =       norm([outDyn.Fi_tot(1,1);outDyn.Fi_tot(2,1);outDyn.Fi_tot(3,1)]);
    outSim.Fitot_norm(i,1)     =       Fitot_norm;
    