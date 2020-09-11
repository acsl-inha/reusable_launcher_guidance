
%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : CnvPos_D2E.m                                                 %
%                                                                         %
%                           - Created by C. H. Lee, 2020. 07. 18.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function Pos_E  =   CnvPos_D2E( Pos_Geod )
    
%.. Global and Persistent Variables 

    global datUnit 

%.. Local Variables

    lat_d  	=       Pos_Geod(1,1) ; 
    lon_d  	=       Pos_Geod(2,1) ; 
    alt_d	=       Pos_Geod(3,1) ; 
    
%.. Get Geocentric Position 

    slat    =       sin( lat_d ) ; 
    clat    =       cos( lat_d ) ; 
    slon    =       sin( lon_d ) ; 
    clon    =       cos( lon_d ) ; 

	r0   	=       datUnit.Semi * ( 1.0 - datUnit.Flattening * ( 1.0 - cos( 2.0 * lat_d ) ) / 2.0 + 5.0 * ( datUnit.Flattening )^2 * ( 1 - cos( 4.0 * lat_d ) ) / 16.0 ) ;
    magRib  =       r0 + alt_d ; 

    Xe      =       magRib * clat * clon ; 
    Ye      =       magRib * clat * slon ; 
    Ze      =       magRib * slat ; 
    
%.. Output 
    
    Pos_E 	=       [ Xe ; Ye ; Ze ] ;
