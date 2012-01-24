% normalize2DpointsCentroid - Normalization of 2D points so that the
%                             centroid is at the origin
%
% Normalizes the points so that the origin is at the centroind of the
% points
%
% Input  - X -> (2xn) matrix of image points
%
% Output - Xn -> (2xn) matrix of normalized points 
%        - T -> (2x1) Transformation matrix
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [Xn,T] = normalize2DpointsCentroid(X)

    % Calculate centroid
    c = mean(X(1:2,:)')';
    
    %if(numel(c)==1)
    %    X(1:2,:)'
    %    c
    %    pause
    %end;
    
    % Adjust points so that the origin is at the centroid
    Xn = X;
    Xn(1,:) = Xn(1,:)-c(1);
    Xn(2,:) = Xn(2,:)-c(2);
    
    %Return the transformation
    T = c;
