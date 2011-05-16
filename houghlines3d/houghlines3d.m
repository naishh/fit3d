% this file transfers the houghlines to 3d space
close all;
clear Houghlines3dWall
clear Houghlines3d
disp('loaded real houghlines from cache')
clear Houghlines
load Houghlines
load Walls

colors = {'r', 'b', 'c', 'm', 'y', 'k'};



% config
windowsPlot = 1;

houghEndpointsFileName 	= 'hough-endpoints.obj';
houghLinesFileName     	= 'hough-lines.obj';
% flush and instantiate files
fp = fopen(houghEndpointsFileName, 'w'); fclose(fp);
fp = fopen(houghLinesFileName    , 'w'); fclose(fp);

if windowsPlot
	figBuilding = plotBuilding();
end


for w=1:length(Walls)
	Houghlines3dWall{w} = struct();
end

% todo cache functie bouwe ouwe
if exist('imgs') == 0
	imgs = loadImgs(startPath,1,6);
end


% select interesting houghlines (by hand)
HoughlinesSelecta{1} = [Houghlines{1}(1), Houghlines{1}(2), Houghlines{1}(3)];
HoughlinesSelecta{2} = [Houghlines{2}(1), Houghlines{2}(3), Houghlines{2}(5)];
HoughlinesSelecta{3} = [Houghlines{3}(1), Houghlines{3}(2), Houghlines{3}(3),Houghlines{3}(4)];
HoughlinesSelecta{4} = [Houghlines{4}(1), Houghlines{4}(2), Houghlines{4}(3),Houghlines{3}(4)];
HoughlinesSelecta{5} = [Houghlines{5}(1), Houghlines{5}(2)];
HoughlinesSelecta{6} = [Houghlines{6}(1)];

% use new selecion
Houghlines = HoughlinesSelecta;

% loop through different views
for imNr=1:length(Houghlines)
	figPhoto = figure();
	figure(figPhoto);
	imshow(imgs{imNr});
	hold on;

	% loop through found houghlines endpoints and project to 3D
	for i=1:length(Houghlines{imNr})
		imNr
		i
		pause;


		figure(figPhoto);
		plotHoughline(Houghlines, imNr, i);

		[HoughLineEndpoint1, wallNo]  = get3Dfrom2D(Houghlines{imNr}(i).point1', imNr, PcamX,Kcanon10GOOD, Walls);
		[HoughLineEndpoint2, wallNo]  = get3Dfrom2D(Houghlines{imNr}(i).point2', imNr, PcamX,Kcanon10GOOD, Walls);

		writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint1, 0.1);
		writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint2, 0.1);

		if windowsPlot
			% matlab plot for windows computers
			X = [HoughLineEndpoint1(1), HoughLineEndpoint2(1)];
			Y = [HoughLineEndpoint1(2), HoughLineEndpoint2(2)];
			Z = [HoughLineEndpoint1(3), HoughLineEndpoint2(3)];
			% activate fig
			figure(figBuilding);
			plot3(X, Y, Z, ['-',colors{mod(i,length(colors))+1}],'LineWidth', 2);
		end


		% quickfix, for houghlines that are classified as wrong wall 
		if (imNr  == 1 && i == 1) || (imNr == 3 && i == 2)
			wallNo = 10;
		end
		if (imNr  == 1 && i == 5) || (imNr == 1 && i == 6) || (imNr == 2 && i == 7)
			wallNo = 4;
		end
		if (imNr == 2 && i == 6) 
			wallNo = 7;
		end

		Houghlines3d{imNr}(i).point1 = HoughLineEndpoint1;
		Houghlines3d{imNr}(i).point2 = HoughLineEndpoint2;
		Houghlines3d{imNr}(i).wallNo = wallNo;

		wallNo
		length(Houghlines3dWall{wallNo})

		% calc index 
		idx = length(Houghlines3dWall{wallNo});
		idx = idx+1;

		% saving content on wall index
		Houghlines3dWall{wallNo}(idx).point1 = HoughLineEndpoint1;
		Houghlines3dWall{wallNo}(idx).point2 = HoughLineEndpoint2;
		Houghlines3dWall{wallNo}(idx).wallNo = wallNo;
		Houghlines3dWall{wallNo}(idx).test1 = 1;

		% writeObjLineThick(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2,'black', 1);
		writeObjLine(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2, 'black');
	end

end

disp('saving Houghlines3d in directory ...');
pwd
save Houghlines3d
save Houghlines3dWall
