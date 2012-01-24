% fromRotation2Euler - Obtains the euler angles given the rotation matrix
%
%
% This algorithm was obtained from haifeng.gong@gmail.com from google
% groups
%
%
% Input  - orthm -> 3x3 rotation matrix
%
% Output - ange  -> 3x1 euler angles
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function ang = fromRotation2Euler(orthm)

    ang(1) = asin(orthm(1,3)); 
    ang(2) = angle( orthm(1,1:2)*[1 ;i] ); 
    yz = orthm* ...
        [orthm(1,:)',...
         [-sin(ang(2)); cos(ang(2)); 0],...
         [-sin(ang(1))*cos(ang(2)); -sin(ang(1)*sin(ang(2)));
    cos(ang(1))] ];

    ang(3) = angle(yz(2,2:3)* [1; i]); 
