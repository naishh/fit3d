% calculates the line spanned by the camera center and the 2d image coord
function lineCoord = getProjectionLine(xy, CC, K, PcamAbs, imNr)
%% input vars:

% xy, the 2d pixel coordinate
% CC, the camera center (for first pic this is [0;0;0]

if length(xy) == 2
	% disp('homog coord not found')
	xyH = [xy;1];
else 
	% disp('homog coord found')
	xyH = xy'
end

disp('test')
% the pixel in 3d space
R = PcamAbs(:,1:3,imNr);
T = PcamAbs(:,4,imNr);

xy3D = R*inv(K)*xyH+T;

% to transfer back to 2d i do this:
%xyH = inv(R) * K * (xy3D - T) 

% the direction vector
xyzDirection = xy3D - CC;

% v presents the position on the line (v = 0 => CC, v = 1 => xy3D)
% 3dLineEq = CC + v * xyzDirection

lineCoord = zeros(2, 3);
lineCoord(1,:) = CC;
lineCoord(2,:) = CC + xyzDirection;
