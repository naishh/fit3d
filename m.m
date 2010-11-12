close all;
% run fit3d setup
load outputVars_scriptComputeCameraMotion.mat
load outputVars_Skyline.mat


%[SkylineX, SkylineY] = getSkyLineMain();

% todo make camera center depended of translation in P
P1 = PcamX(:,:,1) % = [I,0]
fullFilename = [Files.dir,Files.files(1).name]
Im = imread(fullFilename);
%figure; imshow(Im);

figure;
hold on;

fp = fopen('t.obj', 'w')
fclose(fp)

% loop through skyline pixels
maxI = 800;
for i=1:10:maxI
	% the pixel coordinate 
	xy = [SkylineX(i);SkylineY(i)]

	maxV = 100;
	CC = [0;0;0]
	lineCoord = pointsTo3DLine(xy, CC, Kcanon10GOOD, maxV)
	X = lineCoord(:,1)
	Y = lineCoord(:,2)
	Z = lineCoord(:,3)
	plot3(X,Y,Z)
	% write vertices
	XYZtoObj(X,Y,Z)

	%pause;
end


% write points
fp = fopen('t.obj', 'a')
for i=1:maxI
	fprintf(fp, 'p %d\n', i)
end
fclose(fp)

% todo:
% draw multiple lines in 5d with plot3
