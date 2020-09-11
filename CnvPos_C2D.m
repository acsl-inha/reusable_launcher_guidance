
%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : CnvPos_C2D.m                                                 %
%                                                                         %
%                           - Created by C. H. Lee, 2020. 07. 18.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function Pos_d    =   CnvPos_C2D( Pos_c )
    
%.. Global and Persistent Variables 

    global datUnit 
    
%.. Local Variables 

    lat_c           =       Pos_c(1,1) ; 
    lon_c           =       Pos_c(2,1) ; 

%.. Get Geodetic Position 

	lat_d           =       atan( tan( lat_c ) / ( 1 - ( datUnit.Flattening )^2 ) ) ;
	lon_d           =       lon_c ;
	r0              =       datUnit.Semi * ( 1.0 - datUnit.Flattening * ( 1.0 - cos( 2.0 * lat_d ) ) / 2.0 + 5.0 * ( datUnit.Flattening )^2 * ( 1 - cos( 4.0 * lat_d ) ) / 16.0 ) ;
	alt_d           =       R - r0 ;
    
%.. Output 
    
    Pos_d           =       [ lat_d ; lon_d ; alt_d ] ;