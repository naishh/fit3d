% this file transfers the houghlines to 3d space
close all;
clear Houghlines3dWall
clear Houghlines3d
disp('loaded real houghlines from cache')
clear Houghlines

% todo fix quickfix because Houghlines overwrites the startpath
%startPath2 = startPath;
load Houghlines;
%startPath = startPath2;
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
	figBuilding = plotBuilding(Walls,[]);
end


for w=1:length(Walls)
	Houghlines3dWall{w} = struct();
end

if exist('imgs') == 0
	imgs = loadImgs(startPath,1,6);
end


% select interesting houghlines (by hand)
HoughlinesSelecta{1} = [Houghlines{1}(1), Houghlines{1}(2), Houghlines{1}(3)];
HoughlinesSelecta{2} = [Houghlines{2}(1), Houghlines{2}(3), Houghlines{2}(5)];
%HoughlinesSelecta{3} = [Houghlines{3}(1), Houghlines{3}(2), Houghlines{3}(3),Houghlines{3}(4)];
HoughlinesSelecta{3} = [Houghlines{3}(2), Houghlines{3}(3),Houghlines{3}(4)];
HoughlinesSelecta{4} = [Houghlines{4}(1), Houghlines{4}(2), Houghlines{4}(3)];
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
		%pause;

		figure(figPhoto);
		plotHoughline(Houghlines, imNr, i);

		
		Houghline = Houghlines{imNr}(i);



		% intersect left right en mid point houghline
		[HoughLineEndpoint1, wallNoP1]  = get3Dfrom2D(Houghline.point1', imNr, PcamX,Kcanon10GOOD, Walls, 0);
		[HoughLineEndpoint2, wallNoP2]  = get3Dfrom2D(Houghline.point2', imNr, PcamX,Kcanon10GOOD, Walls, 0);
		% writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint1, 0.1);
		% writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint2, 0.1);
		HoughlineMidpoint = (Houghline.point1 + Houghline.point2)/2;
		[Dummy, closestWall]  = get3Dfrom2D(HoughlineMidpoint', imNr, PcamX,Kcanon10GOOD, Walls, 0);
		[wallNoP1, closestWall, wallNoP2]
		
		% if (wallNoP1 == closestWall) && (wallNoP2 == closestWall) 
		% 	correction=0;
		% else 
		% 	correction=1;
		% end


		% matlab plot 
		if windowsPlot
			X = [HoughLineEndpoint1(1), HoughLineEndpoint2(1)];
			Y = [HoughLineEndpoint1(2), HoughLineEndpoint2(2)];
			Z = [HoughLineEndpoint1(3), HoughLineEndpoint2(3)];
			% activate fig
			figure(figBuilding);
			%plot3(X, Y, Z, ['-',colors{mod(i,length(colors))+1}],'LineWidth', 2);
			%plot3(X, Y, Z, ['-','b'],'LineWidth', 2);
			% calc corrected houghline
			[HoughLineEndpoint1corrected, wallNoP1]  = get3Dfrom2D(Houghline.point1', imNr, PcamX,Kcanon10GOOD, Walls, closestWall);
			[HoughLineEndpoint2corrected, wallNoP2]  = get3Dfrom2D(Houghline.point2', imNr, PcamX,Kcanon10GOOD, Walls, closestWall);

			X = [HoughLineEndpoint1corrected(1), HoughLineEndpoint2corrected(1)];
			Y = [HoughLineEndpoint1corrected(2), HoughLineEndpoint2corrected(2)];
			Z = [HoughLineEndpoint1corrected(3), HoughLineEndpoint2corrected(3)];
			% after correction
			plot3(X, Y, Z, ['-','k'],'LineWidth', 2);

			% plot midpoint
			Xmidpoint = (X(1)+X(2))/2; Ymidpoint = (Y(1)+Y(2))/2; Zmidpoint = (Z(1)+Z(2))/2;
			plot3(Xmidpoint, Ymidpoint, Zmidpoint, ['+' ,'r'], 'LineWidth', 2)
		end

		% calc index 
		idx = length(Houghlines3dWall{closestWall});
		idx = idx+1;

		% saving content on wall index
		Houghlines3dWall{closestWall}(idx).point1 = HoughLineEndpoint1;
		Houghlines3dWall{closestWall}(idx).point2 = HoughLineEndpoint2;
		Houghlines3dWall{closestWall}(idx).closestWall = closestWall;

		%% writeObjLineThick(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2,'black', 1);
		%writeObjLine(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2, 'black');


	end
	pause;

end

disp('saving Houghlines3dWall in directory ...[temp NOT]');
pwd
%%save Houghlines3d
%save Houghlines3dWall
