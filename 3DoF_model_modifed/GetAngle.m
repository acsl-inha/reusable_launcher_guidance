%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : GetAngle.m                                                   %
%                                                                         %
%                   - Created by C. H. Lee, 2016. 07. 07                  %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function ANG2 = GetAngle( VEC3 )

    ANG2(1,1)   =   atan2( VEC3(2,1), VEC3(1,1) ) ;                          % Azimuth Angle
    ANG2(2,1)   =   atan2( -VEC3(3,1), sqrt( VEC3(1,1)^2 + VEC3(2,1)^2 ) ) ; % Elevation Angle