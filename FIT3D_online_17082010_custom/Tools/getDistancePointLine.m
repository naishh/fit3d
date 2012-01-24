% getDistancePointLine - Distance from point to line
%
%
% Computes the minimum distance from a point in space (X,Y,Z) to a line
% defined as (m,b) such that Y=mX+b. The distance is the lenght of the
% perpendicular segment that crosses the line and passes through the point.
%
%
% Input  - P -> (3x1) point coordinates in space
%        - L -> (2x1) Line parameters m and b
%
% Output - d -> (1x1) Distance between the given point and the closes point
%                     in the line
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function d = getDistancePointLine(P,L)

    % Line parameters
    m = L(1);
    b = L(2);

    % Obtain slope of orthogonal line
    mo= -1/L(1);

    % For every point, calculate the orthogonal line that pases through the
    % point
    bo = P(:,2)-mo.*P(:,1);


    % Calculate the intersection of both lines for every point
    Xint = (bo-b)./(m-mo);
    Yint = mo.*Xint+bo;

    % Calculate the distance between each pair of points
    d = sqrt((Xint-P(:,1)).^2+(Yint-P(:,2)).^2);
