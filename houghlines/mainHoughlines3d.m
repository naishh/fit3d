% this file saves the houghlines found in the images
close all;

% config
windowsPlot = 0
useFakeHoughlines=1;
loadFromCache=1;


% todo give PcamX to function as a param
% if workspace vars are not loaded
if exist('PcamX') == 0
	disp('load mats');
	load '../mats/outputVars_scriptComputeCameraMotion.mat'
	load '../mats/Walls.mat'
	load '../mats/imBWSkylines.mat'
end


if loadFromCache == 1
	if useFakeHoughlines == 1
		load fakeHoughlines
		Houghlines = fakeHoughlines
	else
		load Houghlines
	end
end


houghEndpointsFileName 	= 'hough-endpoints.obj';
houghLinesFileName     	= 'hough-lines.obj';
% flush and instantiate files
fp = fopen(houghEndpointsFileName, 'w'); fclose(fp);
fp = fopen(houghLinesFileName    , 'w'); fclose(fp);


% loop through different views
for imNr=1:length(imBWSkylines)
	imNr

	if windowsPlot
		figure;
		hold on;
		plotBuilding();
	end

	if useFakeHoughlines ~= 1
		Houghlines{imNr} = getHoughlines(imBWSkylines{imNr})
	end

	% loop through found houghlines endpoints and project to 3D
	for i=1:length(Houghlines{imNr})
		HoughLineEndpoint1 = get3Dfrom2D(Houghlines{imNr}(i).point1', imNr, PcamX,Kcanon10GOOD, WALLS);
		HoughLineEndpoint2  = get3Dfrom2D(Houghlines{imNr}(i).point2', imNr, PcamX,Kcanon10GOOD, WALLS);

		writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint1, 0.1);
		writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint2, 0.1);

		if windowsPlot
			% matlab plot for windows computers
			X = [HoughLineEndpoint1(1), HoughLineEndpoint2(1)];
			Y = [HoughLineEndpoint1(2), HoughLineEndpoint2(2)];
			Z = [HoughLineEndpoint1(3), HoughLineEndpoint2(3)];
			plot3(X, Y, Z, '-');
		end

		% writeObjLineThick(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2,'black', 1);
		writeObjLine(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2, 'black');
	end

end

save Houghlines
