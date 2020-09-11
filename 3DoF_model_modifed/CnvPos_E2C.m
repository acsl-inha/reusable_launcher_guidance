%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : CnvPos_E2C.m                                                 %
%                                                                         %
%                           - Created by C. H. Lee, 2020. 07. 18.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function Pos_Geoc =   CnvPos_E2C( Ribe )
    
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
    
    if( lon_c < 0.0 ) 
       
        lon_c   =   lon_c + 2 * pi ; 
        
    end
  
	alt_c 	=       magRib - datUnit.Rmean ;
    
%.. Output 

	Pos_Geoc =       [ lat_c ; lon_c ; alt_c ] ;