% normalizePcam - Normalizes a 3x4 camera matrices to 4x4 
%
%
%
% Input  - Pcam      -> (3x4xn) n camera matrices
%
% Output - PcamN     -> (4x4xn7) n normalized camera matrices
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [PcamN] = normalizePcam(Pcam)

    
    PcamN = Pcam;
    
    for i=1:size(Pcam,3)

        PcamN(4,:,i) = [0,0,0,1];

    end;
