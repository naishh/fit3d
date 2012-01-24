% normalize2Dpoints - Normalization of 2D image points for the DLT
%                     algorithm
%
% Normalizes the points so that the origin is at the centroind of the
% points and the average distance to the origin is sqr(2)
%
% Input  - X  -> (2xn) matrix of image points (homogeneous points 3xn also
%                      work)
%
% Output - Xn -> (3xn) matrix of normalized points (including w=1)
%        - T  -> (3x3) Transformation matrix
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function [Xn, T] = normalize2Dpoints(X)

    % If the points are not homogeneous, make them
    if(size(X,1)==2)
        Xt = ones(3,size(X,2));
        Xt(1:2,:) = X;
        X = Xt;
    end;

        
    % Normalize with the centroid
    Xn = X;
    [Xn(1:2,:),c1] = normalize2DpointsCentroid(X(1:2,:));
    
    % Compute the mean distance
    meandistance = mean(sqrt(Xn(1,:).^2+Xn(2,:).^2));

    % Compute the scale factor
    scale = sqrt(2)/meandistance;

    % Transformation matrix
    T = [scale,   0,     -scale*c1(1);
            0,    scale, -scale*c1(2);
            0,    0,       1];

    % Recalculate points
    Xn = T*X;
