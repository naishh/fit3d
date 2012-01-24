% grad2rad - From grad to radians 
%
%
%
% Input  - a    -> (1x1) Rad
%
% Output - g    -> (1x1) Grad
%          
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function g = rad2grad(a)

% Converts from radians to degrees

g = a*180/pi;
