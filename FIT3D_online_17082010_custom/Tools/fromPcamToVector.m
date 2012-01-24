% fromPcamToVector - Transform the 3x4 camera representation to a vector
% containing the rotation in quaternion format and the translation vector.
%
%
% Input  - Pcam   -> (3x4xn) n camera matrices
%
% Output - Pcamv  -> (7\times n x 1) Camera representation in vector format
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function Pcamv = fromPcamToVector(Pcam)

    Pcamv = [];
    
    for(i=1:size(Pcam,3))
               
        Pcamv = [Pcamv;qcR(Pcam(:,1:3,i));Pcam(:,4,i)];
        
    end;
    
    
