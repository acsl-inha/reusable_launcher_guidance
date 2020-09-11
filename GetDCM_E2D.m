%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : GetDCM_E2D.m                                                 %
%                                                                         %
%                           - Created by C. H. Lee, 2020. 07. 18.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function cE_D   =   GetDCM_E2D( Pos_Geod )

%.. Local Variables 
    
    lat_d       =   Pos_Geod(1,1) ; 
    lon_d       =   Pos_Geod(2,1) ; 

%.. Get DCM     

    slat        =   sin( lat_d ) ; 
    clat        =   cos( lat_d ) ; 
    slon        =   sin( lon_d ) ; 
    clon        =   cos( lon_d ) ; 
    
    cE_D        =   [ -slat*clon, -slat*slon,  clat ; 
                           -slon,       clon,   0.0 ;
                      -clat*clon, -clat*slon, -slat ] ; 
