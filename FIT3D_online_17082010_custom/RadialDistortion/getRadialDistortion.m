% getRadialDistortion - Obtain radial distortion paremeters and center of
% distortion by minimizing a cost function
%
%
% Given the radial distortion parameters based on Zisserman´s model (p.190)
% and the center of distortion (typically the center of the image) it 
% corrects the given set of points.
%
%
% Input  - X    -> nx2xl   n points for l lines in image coordinates
%        - K0   -> kx1     Initial guess for radial distortion parameters
%        - kc   -> 2x1     Initial guess for center of radial distortion
%        - r    -> 1x1     Maximum number of function evaluations for the
%                          minimization procedure
%
% Output - K    -> 6x1     Radial distortion parameters (4) and center of
%                          radial distortion (2)
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function K = getRadialDistortion(X,K0, kc,r)


% Minimice the cost function 
options = optimset('Display','iter','MaxIter',r,'MaxFunEvals',r,'TolX',1.90744e-28);
K = lsqnonlin(@(k) getDistortionError(X,k),[K0;kc],-550,550,options);
