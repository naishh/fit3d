% projects cornerpoints from 2d to 3d wall to 2d viewpoint straight from wall
function cornerScaleAccu = project2square(cornerScaleAccu,scale,projectionScale)
% quickfix

load Walls
load PcamAbs
load Kcanon10GOOD

% TODO Check wallnr
wallNr = 7;
imNr = 3;
wallNormal = getNormalFromWall(Walls, wallNr);
wallNormal = wallNormal/norm(wallNormal); % normalise wall normal
zAxis = [0 0 1];
rotationVector = cross(zAxis, wallNormal);
angle = acos(dot(zAxis, wallNormal)) % could also be -R!!
R = getRotationMatrix(rotationVector, angle);
T = [0 0 0];

Corners = cornerScaleAccu(scale).Corners
for k = 1:length(Corners)
	xy1 = Corners(k,:)';
	% project to 3d
	% TODO MAYBE IT IS IMAGE 4
	[xyz1, dummy] = get3Dfrom2D(xy1,imNr,PcamAbs,Kcanon10GOOD,Walls,9);
	%reproject to 2d
	% TODO only works for image 1?
	xy1Proj = homog22D(inv(R) * xyz1');
	cornerScaleAccu(scale).CornersProjected(k,:) = projectionScale * xy1Proj;
end
