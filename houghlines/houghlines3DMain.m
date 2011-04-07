clear;
close all;
plotBuilding();
startPaths = {'C:/Temp/tkosteli/fit3d/','/mnt/linuxoldDocs/documents/studie/scriptie/git/','E:/fit3d/'}

for i=1:length(startPaths)
	path(path,startPaths{i});
	path(path,[startPaths{i}, 'fit3d_includes']);
	path(path,[startPaths{i}, 'mats']);
end

% todo give PcamX to function as a param
% if workspace vars are not loaded
if exist('PcamX') == 0
	disp('load PcamX and Walls');
	load '../mats/outputVars_scriptComputeCameraMotion.mat'
	load '../mats/WALLS.mat'
	load '../mats/imBWSkylines.mat'
end


houghEndpointsFileName 	= 'hough-endpoints.obj';
houghLinesFileName     	= 'hough-lines.obj';
% flush and instantiate files
fp = fopen(houghEndpointsFileName, 'w'); fclose(fp);
fp = fopen(houghLinesFileName    , 'w'); fclose(fp);

% loop through different views
for imNr=1:length(imBWSkylines)
	lines = houghlinesMain(imBWSkylines{imNr})


	% loop through found houghlines endpoints and project to 3D
	for i=1:length(lines)
		HoughLineEndpoint1 = get3Dfrom2D(lines(i).point1', imNr, PcamX,Kcanon10GOOD, WALLS);
		HoughLineEndpoint2  = get3Dfrom2D(lines(i).point2', imNr, PcamX,Kcanon10GOOD, WALLS);

		% writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint1, 0.1);
		% writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint2, 0.1);

		disp('plotting')
		X = [HoughLineEndpoint1(1), HoughLineEndpoint2(1)];
		Y = [HoughLineEndpoint1(2), HoughLineEndpoint2(2)];
		Z = [HoughLineEndpoint1(3), HoughLineEndpoint2(3)];
		plot3(X, Y, Z, '-');

		% writeObjLineThick(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2,'black', 1);
		writeObjLine(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2, 'black');
	end
	pause;
	figure;
	hold on;
	plotBuilding();

end
