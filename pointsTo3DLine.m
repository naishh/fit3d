function lineCoord = pointsTo3DLine(xy, CC, K, PcamXAbs, imNr)
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

% the pixel in 3d space
xy3D = PcamXAbs(:,1:3,imNr)*inv(K)*xyH+PcamXAbs(:,4,imNr);


% add world rotations translations from P 
%for i=2:imNr
	%xy3D = rotateTranslateCoord(xy3D, PcamX(:,:,imNr));
%end




% remove homogenity
%xy3D = xy3D/xy3D(4)
%xy3D = xy3D(1:3)


% add world rotations translations from P 
%for i=2:imNr
	xy3D = rotateTranslateCoord(xy3D, PcamX(:,:,imNr));
%end



% remove homogenity
%xy3D = xy3D/xy3D(4)
%xy3D = xy3D(1:3)

% the direction vector
xyzDirection = xy3D - CC;

% v presents the position on the line (v = 0 => CC, v = 1 => xy3D)
% 3dLineEq = CC + v * xyzDirection

lineCoord = zeros(2, 3);
lineCoord(1,:) = CC;
lineCoord(2,:) = CC + xyzDirection;
