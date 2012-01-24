% grad2rad - From radians to grads
%
%
%
% Input  - a    -> (1x1) Grad
%
% Output - g    -> (1x1) Rad
%          
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function g = grad2rad(a)

% Converts degrees to radians

g = a*pi/180;
