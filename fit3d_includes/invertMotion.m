% invertMotion - Invert the camera motion (from camera 1 to camera 2, or
% from camera 2 to camera 1)
%
%
%
% Input  - Pcam    -> (4x4xn) Camera motion (normalized)
%
% Output - PcamInv -> (4x4xn) Inverted camera motion (normalized)
%          
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function PcamInv = invertMotion(Pcam)

PcamInv = Pcam;
for(i=1:size(Pcam,3))
    PcamInv(:,:,i) = inv(PcamInv(:,:,i));
end;
