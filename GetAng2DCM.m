%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : GetAng2DCM.m                                                 %
%                                                                         %
%                           - Created by C. H. Lee, 2016. 07. 07.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function DCM    =   GetAng2DCM( ANG2 )

  %.. Local Variables 

    Psi         =   ANG2(1,1) ; 
    The         =   ANG2(2,1) ; 

%.. Get DCM 

    spsi        =   sin( Psi ) ; 
    cpsi        =   cos( Psi ) ; 
    sthe        =   sin( The ) ; 
    cthe        =   cos( The ) ; 

    DCM_Psi     =   [  cpsi, spsi, 0.0 ; 
                      -spsi, cpsi, 0.0 ; 
                        0.0,  0.0, 1.0 ] ;
                   
    DCM_The     =   [  cthe, 0.0, -sthe ;
                       0.0 , 1.0,  0.0 ; 
                       sthe, 0.0,  cthe ] ; 
                   
    DCM         =   DCM_The * DCM_Psi ; 