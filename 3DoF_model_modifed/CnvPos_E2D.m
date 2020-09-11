
%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : CnvPos_E2D.m                                                 %
%                                                                         %
%                           - Created by C. H. Lee, 2020. 07. 18.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function Pos_Geod    =   CnvPos_E2D( Ribe )
    
%.. Global and Persistent Variables 

    global datUnit 

%.. Local Variables

    Xe      =       Ribe(1,1) ; 
    Ye      =       Ribe(2,1) ; 
    Ze      =       Ribe(3,1) ; 
    
%.. Get Geocentric Position 

    magRib  =       norm( Ribe ) ;
	lat_c 	=       asin( Ze / magRib ) ;
	lon_c	=       atan2( Ye, Xe ); 
    
    if( lon_c < 0 ) 
       
        lon_c   =   lon_c + 2 * pi ; 
        
    end
  
	lat_d	=       atan( tan( lat_c ) / ( 1 - ( datUnit.Flattening )^2 ) ) ;
	lon_d 	=       lon_c ;
	r0   	=       datUnit.Semi * ( 1.0 - datUnit.Flattening * ( 1.0 - cos( 2.0 * lat_d ) ) / 2.0 + 5.0 * ( datUnit.Flattening )^2 * ( 1 - cos( 4.0 * lat_d ) ) / 16.0 ) ;
	alt_d  	=       magRib - r0 ;
    
%.. Output 
    
    Pos_Geod        =       [ lat_d ; lon_d ; alt_d ] ;