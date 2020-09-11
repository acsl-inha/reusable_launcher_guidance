%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : GetAngle2DCM.m                                               %
%                                                                         %
%                           - Created by C. H. Lee, 2016. 07. 07.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function DCM    =   GetAngle2DCM( ANG2 )

    Psi         =   ANG2(1,1) ; 
    The         =   ANG2(2,1) ; 
    
    DCM_Psi     =   [  cos( Psi ), sin( Psi ),  0.0        ; 
                      -sin( Psi ), cos( Psi ),  0.0        ; 
                       0.0       , 0.0       ,  1.0        ] ;
                   
    DCM_The     =   [  cos( The ), 0.0       , -sin( The ) ;
                       0.0       , 1.0       ,  0.0        ; 
                       sin( The ), 0.0       ,  cos( The ) ] ; 
                   
    DCM         =   DCM_The * DCM_Psi ; 