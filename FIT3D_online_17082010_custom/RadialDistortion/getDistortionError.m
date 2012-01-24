% getDistortionError - Error estimation based on line fitting
%
%
% Computes the error as the sum of the distances between the given p points
% (known to belong to n lines) and the line that is approximated with the
% set of radially corrected points.
%
%
% Input  - X -> (px2xn) p image points known to belong to a lines. Each
%                       line (n in total) is given by n points.
%        - k -> (6x1)   Radial distortion parameters (4) based on Zisserman´s model
%                       (p.135) and center of distortion (2)
%
% Output - d -> (1x1)   Summed distance 
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function cost = getDistortionError(X,k)

% Distortion parameters
K = k(1:end-2);
% Center of distortion
Xc = k(end-1:end);

% Initialize distance vector
d = zeros(size(X,1),1);

% For every point
for i=1:size(X,3)
    
    % Obtain rectified points
    Xr = getRectifiedPoints(K, Xc, X(:,:,i));

    % Fit a line to the points
    L = polyfit(Xr(:,1),Xr(:,2),1);

    % Obtain distances to the points
    d = d+abs(getDistancePointLine(Xr,L));
    
end;


% Return the sum of distances
cost = d;
