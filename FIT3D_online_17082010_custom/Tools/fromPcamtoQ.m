% fromPcamToQ - Converts the rotations in Pcam matrices to the
% corresponding quaternions
%
%
% Input  - Pcam   -> (3x4xn) n camera matrices
%
% Output - Q      -> (nx4) quaternions
%          QT     -> (nx7) quaternions and translation vector
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function [Q,QT] = fromPcamtoQ(Pcam)

    Q = zeros(size(Pcam,3),4);
    QT = zeros(size(Pcam,3),7);
    
    for i=1:size(Pcam,3)
        Q(i,:) = qcR(Pcam(:,1:3,i))';
        QT(i,:) = [Q(i,:),Pcam(:,4,i)'];
    end;

