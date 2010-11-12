function lineCoord = pointsTo3DLine(xy, CC, K, maxV)
%% input vars:

% xy, the 2d pixel coordinate
% CC, the camera center (for first pic this is [0;0;0]
% maxV, number of 3d points on the line that will be generated

% the homogeneous pixel coordinate 
xyH = [xy;1];

% the pixel in 3d space
xy3D = K * xyH;

% the direction vector
xyzDirection = xy3D - CC;

% v presents the position on the line (v = 0 => CC, v = maxV => xy3D)
% 3dLineEq = CC + v * xyzDirection

lineCoord = zeros(2, 3);
lineCoord(1,:) = CC;
lineCoord(2,:) = CC + xyzDirection;
