%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : GetDCM_I2E.m                                                 %
%                                                                         %
%                           - Created by C. H. Lee, 2020. 07. 18.         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

function cI_E    =   GetDCM_I2E( ang )

%.. Local Variables

    cang        =   cos( ang ) ;
    sang        =   sin( ang ) ; 
    
%.. Get DCM    

    cI_E        =   [  cang, sang, 0.0 ; 
                      -sang, cang, 0.0 ; 
                        0.0,  0.0, 1.0 ] ;