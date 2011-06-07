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
		%pause;

		figure(figPhoto);
		plotHoughline(Houghlines, imNr, i);

		
		Houghline = Houghlines{imNr}(i);
		subCoords = calcLineSubCoords(Houghline, 7)
		disp('start heuristic voting');
		% the houghline is assocated with the wall where the most in between
		% points are close to
		for subCoord = 1:length(subCoords)
			subCoord
			[Dummy, wallNo]  = get3Dfrom2D(subCoords{subCoord}', imNr, PcamX,Kcanon10GOOD, Walls, 0);
			wallNos(subCoord) = wallNo;
			% todo visualize this? with distance arrows and stuff
		end
		% todo compare results with wall voting and without
		wallNos 
		wallNosOccured = zeros(1,length(wallNos));
		% for each wall store the number of times this wall was the closest candidate
		for w = 1:length(wallNos)
			wallNosOccured(wallNos(w)) = sum(wallNos==wallNos(w));
		end
		wallNosOccured
		% note with a set of 0 0 0 0 4 4, there are two maximums, it takes the first it finds
		[dummy, closestWall] = max(wallNosOccured);




		% plot
		if windowsPlot
			[HoughLineEndpoint1, wallNo]  = get3Dfrom2D(Houghlines{imNr}(i).point1', imNr, PcamX,Kcanon10GOOD, Walls, closestWall);
			[HoughLineEndpoint2, wallNo]  = get3Dfrom2D(Houghlines{imNr}(i).point2', imNr, PcamX,Kcanon10GOOD, Walls, closestWall);
			% writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint1, 0.1);
			% writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint2, 0.1);

			% matlab plot for windows computers
			X = [HoughLineEndpoint1(1), HoughLineEndpoint2(1)];
			Y = [HoughLineEndpoint1(2), HoughLineEndpoint2(2)];
			Z = [HoughLineEndpoint1(3), HoughLineEndpoint2(3)];
			% activate fig
			figure(figBuilding);
			plot3(X, Y, Z, ['-',colors{mod(i,length(colors))+1}],'LineWidth', 2);
		end


		% % quickfix, for houghlines that are classified as wrong wall 
		% if (imNr  == 1 && i == 1) || (imNr == 3 && i == 2)
		% 	closestWall = 10;
		% end
		% if (imNr  == 1 && i == 5) || (imNr == 1 && i == 6) || (imNr == 2 && i == 7)
		% 	closestWall = 4;
		% end
		% if (imNr == 2 && i == 6) 
		% 	closestWall = 7;
		% end
		% if (imNr  == 3 && i == 1)
		%  	closestWall = 10 
		% end


		%Houghlines3d{imNr}(i).point1 = HoughLineEndpoint1;
		%Houghlines3d{imNr}(i).point2 = HoughLineEndpoint2;
		%Houghlines3d{imNr}(i).wallNo = closestWall;

		closestWall
		length(Houghlines3dWall{closestWall})

		% calc index 
		idx = length(Houghlines3dWall{closestWall});
		idx = idx+1;

		% saving content on wall index
		Houghlines3dWall{closestWall}(idx).point1 = HoughLineEndpoint1;
		Houghlines3dWall{closestWall}(idx).point2 = HoughLineEndpoint2;
		Houghlines3dWall{closestWall}(idx).closestWall = closestWall;

		%% writeObjLineThick(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2,'black', 1);
		%writeObjLine(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2, 'black');


		pause;
	end

end

disp('saving Houghlines3dWall in directory ...[temp NOT]');
pwd
%%save Houghlines3d
%save Houghlines3dWall
