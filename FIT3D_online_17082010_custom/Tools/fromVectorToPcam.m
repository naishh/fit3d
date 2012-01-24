% fromVectorToPcam - Inverse of fromPcamToVector
%
%
% Input  - Pcamv  -> (7\times n x 1) Camera representation in vector format
%
% Output - Pcam   -> (3x4xn) n camera matrices
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function Pcam = fromVectorToPcam(Pcamv)

    totalCams = (size(Pcamv,1)/7);


    
    Pcam = zeros(3,4,totalCams);
    
    for(i=1:totalCams)
        
        lindx = i*7-6;
              
        Pcam(:,:,i) = [Rmq(Pcamv(lindx:lindx+3)./norm(Pcamv(lindx:lindx+3))),Pcamv(lindx+4:lindx+6)];
        
    end;
    

    
