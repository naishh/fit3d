% fromQToPcam - Converts the quaternion-translation matrix to Pcam 3x4
% format. The inverse of fromPcamToQ
%
%
% Input  - QT     -> (nx7) quaternions and translation vector
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


function [Pcam] = fromQTtoPcam(QT)

    Pcam = zeros(3,4,size(QT,1));

    for i=1:size(Pcam,3)
        Pcam(:,1:3,i) = Rmq(QT(i,1:4));
        Pcam(:,4,i) = QT(i,5:7)';
    end;
