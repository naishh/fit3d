close all;


[SkylineX, SkylineY] = getSkyLineMain();

% todo make camera center depended of translation in P
P1 = PcamX(:,:,1) % = [I,0]
fullFilename = [Files.dir,Files.files(1).name]
Im = imread(fullFilename);
%figure; imshow(Im);

figure;
% loop through skyline pixels
for i=1:10:400
	% the pixel coordinate 
	xy = [SkylineX(i);SkylineY(i)]

	maxV = 10;
	CC = [0;0;0]
	lineCoord = pointsTo3DLine(xy, CC, Kcanon10GOOD, maxV)
	X = lineCoord(1,:)
	Y = lineCoord(2,:)
	Z = lineCoord(3,:)
	plot3(X,Y,Z)

	pause;
end

% todo:
% draw multiple lines in 3d with plot3
