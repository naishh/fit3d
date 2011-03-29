startPathUva = 'C:/Temp/tkosteli/fit3d/'
startPathHome = '/mnt/linuxoldDocs/documents/studie/scriptie/git/'
path(path,startPathUva);
path(path,[startPathUva, 'fit3d_includes']);
path(path,startPathHome);
path(path,[startPathHome, 'fit3d_includes']);

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

for imNr=1:length(imBWSkylines)
	lines = houghlinesMain(imBWSkylines{imNr})


	% loop through found houghlines endpoints and project to 3D
	for i=1:length(lines)
		HoughLineEndpoint1 = get3Dfrom2D(lines(i).point1', imNr, PcamX,Kcanon10GOOD, WALLS);
		HoughLineEndpoint2  = get3Dfrom2D(lines(i).point2', imNr, PcamX,Kcanon10GOOD, WALLS);
		writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint1, 0.1);
		writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint2, 0.1);
		% writeObjLineThick(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2,'black', 1);
		writeObjLine(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2, 'black');
	end

end
