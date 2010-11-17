close all;
% cd ../FIT3D_online_17082010
% FIT3D_setup
% cd ../git
% load outputVars_scriptComputeCameraMotion.mat
%	%[SkylineX, SkylineY] = getSkyLineMain();
% load outputVars_Skyline.mat


% todo make camera center depended of translation in P
P1 = PcamX(:,:,1) % = [I,0]
fullFilename = [Files.dir,Files.files(1).name]
%Im = imread(fullFilename);
%figure; imshow(Im);

figure;
hold on;

fp = fopen('t.obj', 'w');
fclose(fp)

% loop through skyline pixels
maxI = 400;
stepSize = 10;
for i=10:stepSize:maxI
	% the 2d pixel coordinates of the skyline
	xy = [SkylineX(i);SkylineY(i)];

	CC = [0;0;0]
	lineCoord = pointsTo3DLine(xy, CC, Kcanon10GOOD)
	X = lineCoord(:,1); Y = lineCoord(:,2); Z = lineCoord(:,3)
	% plot in matlab
	plot3(X,Y,Z)
	xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis')
	XYZtoObj(X,Y,Z, i/stepSize)
	%pause;
end

% write lines in obj file 
fp = fopen('t.obj', 'a');
for i=1:maxI
	fprintf(fp, 'p %d\n', i);
end
fclose(fp);

