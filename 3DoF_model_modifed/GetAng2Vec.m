%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : GetAng2Vec.m                                                 %
%                                                                         %
%                       - Createc by C. H. Lee, 2016. 07. 07.             %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function VEC3   =   GetAng2Vec( ANG2 ) 

    % Compute Unit Vector from Angle 
    VEC3(1,1)   =   cos( ANG2(2,1) ) * cos( ANG2(1,1) ) ; 
    VEC3(2,1)   =   cos( ANG2(2,1) ) * sin( ANG2(1,1) ) ;
    VEC3(3,1)   =  -sin( ANG2(2,1) ) ; 
    
                                                      