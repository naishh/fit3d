% get corner point of wall
% backproject to image with imNr
% show backprojection in image
% make it rectangular by interpolating 

close all;
load WallsPc;
load PcamAbs; load Kcanon10GOOD;
load imgs;
Walls = WallsPc;

imNr = 1;
wallNr = 2;
R = getRotationMatrixFromWallNormal(Walls,wallNr)

% A = Walls(wallNr, 1:3)';
% B = Walls(wallNr, 4:6)';
% C = Walls(wallNr, 7:9)';
% D = Walls(wallNr,10:12');

nWalls = size(Walls,1);

XY = zeros(nWalls,2);
XYsquare = zeros(nWalls,2);
for pointNr=1:3:(length(Walls)-2)
	% get 3d corner coord of wall
	xy3D = [Walls(wallNr,pointNr),Walls(wallNr,pointNr+1), Walls(wallNr,pointNr+2)]'
	% save 2d at idx 1,2,3 etc.
	i = (pointNr+2)/3;
	i
	XY(i,:) = get2Dfrom3D(xy3D, imNr, PcamAbs, Kcanon10GOOD);
	XYsquare(i,:) = homog22D(inv(R) * xy3D)
end

figPhoto = figure(); figure(figPhoto); imshow(imgs{imNr});
hold on;
plot(XY(:,1), XY(:,2), 'b-');

figure(); imshow(imgs{imNr});
hold on;
XYsquare
XYsquare = 50*(XYsquare+(4*ones(nWalls,2)))
plot(XYsquare(:,1), XYsquare(:,2), 'r-');






