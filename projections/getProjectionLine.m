% calculates the line spanned by the camera center and the 2d image coord
function lineCoord = getProjectionLine(xy, Ccs, K, PcamAbs, imNr)
%% input vars:

% xy, the 2d pixel coordinate
% Ccs(imNr), the camera center (for first pic this is [0;0;0]

if length(xy) == 2
	% disp('homog coord not found')
	xyH = [xy;1];
else 
	% disp('homog coord found')
	xyH = xy';
end

% the pixel in 3d space
R = PcamAbs(:,1:3,imNr);
T = PcamAbs(:,4,imNr);

%as in ReconstructionModeling/build3dcMap.m line 163
xy3D = R*inv(K)*xyH+T;

% to transfer back to 2d:
%xyH = inv(R) * K * (xy3D - T) 
% herstel:
%xyH = K * inv(R) * (xy3D - T) 

% the direction vector

xyzDirection = xy3D - Ccs(:,:,imNr);

lineCoord = zeros(2, 3);
lineCoord(1,:) = Ccs(:,:,imNr);
lineCoord(2,:) = Ccs(:,:,imNr) + xyzDirection;
