% this file transfers the houghlines to 3d space
close all;

% config
windowsPlot = 1;
useFakeHoughlines=1;

load Walls

if useFakeHoughlines == 1
	disp('loaded fake houghlines from cache')
	load fakeHoughlines
	Houghlines = fakeHoughlines
else
	disp('loaded real houghlines from cache')
	load Houghlines
end

houghEndpointsFileName 	= 'hough-endpoints.obj';
houghLinesFileName     	= 'hough-lines.obj';
% flush and instantiate files
fp = fopen(houghEndpointsFileName, 'w'); fclose(fp);
fp = fopen(houghLinesFileName    , 'w'); fclose(fp);

if windowsPlot
	figure;
	hold on;
	plotBuilding();
end


% loop through different views
for imNr=1:1
%for imNr=1:length(Houghlines)
	imNr

	% loop through found houghlines endpoints and project to 3D
	for i=1:length(Houghlines{imNr})
		HoughLineEndpoint1  = get3Dfrom2D(Houghlines{imNr}(i).point1', imNr, PcamX,Kcanon10GOOD, Walls);
		HoughLineEndpoint2  = get3Dfrom2D(Houghlines{imNr}(i).point2', imNr, PcamX,Kcanon10GOOD, Walls);

		writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint1, 0.1);
		writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint2, 0.1);

		if windowsPlot
			% matlab plot for windows computers
			X = [HoughLineEndpoint1(1), HoughLineEndpoint2(1)];
			Y = [HoughLineEndpoint1(2), HoughLineEndpoint2(2)];
			Z = [HoughLineEndpoint1(3), HoughLineEndpoint2(3)];
			plot3(X, Y, Z, '-');
		end

		Houghlines3d{imNr}(i).point1 = HoughLineEndpoint1;
		Houghlines3d{imNr}(i).point2 = HoughLineEndpoint2;

		% writeObjLineThick(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2,'black', 1);
		writeObjLine(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2, 'black');
	end

end

save Houghlines3d