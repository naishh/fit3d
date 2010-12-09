% todo if isp lies within line segment stop evaluating other line segments because they can never have shorter distance

close all;
linesFileName = 'lines.obj';
ispCubesFileName = sprintf('ispCubes.obj');

% if workspace vars are not loaded
if exist('PcamX') == 0
	disp('load PcamX');
	cd mats
	load outputVars_scriptComputeCameraMotion.mat
	  %[SkylineX, SkylineY] = getSkyLineMain();
	load Skylines.mat
	cd ..
end

% todo make camera center depended of translation in P
P1 = PcamX(:,:,1); % = [I,0]
fullFilename = [Files.dir,Files.files(1).name];

% clear files
fp = fopen(linesFileName , 'w'); fprintf(fp,'mtllib colors.mtl\n'); fclose(fp);
fp = fopen(ispCubesFileName, 'w'); fprintf(fp,'mtllib colors.mtl\n'); fclose(fp);

% load WALL coordinates
load('mats/WALLS.mat')

% determine samplesize and range of skyline pixels
minI = 100; maxI = 1300; stepSize = 10;
range1 = minI:stepSize:maxI;
imNr = 1;

Ccs = getCameraCentersFromP(PcamX)


% loop through skyline pixels
for i=range1
	%clear file
	fp = fopen('inpolygon.obj', 'w'); fclose(fp);
	i
	% camera center
	Cc = Ccs{imNr};
	% retrieve 2 coords of line in 3d
	% todo pcamX times skylines
	lineCoord = pointsTo3DLine([Skylines{imNr}.SkylineX(i);Skylines{imNr}.SkylineY(i)], Cc, Kcanon10GOOD);

	nrWalls = length(WALLS);
	% distToIntSectPoint 	= zeros(nrWalls,1);
	intSectPoint 		= zeros(nrWalls,3);
	distPointToWalls 	= inf(nrWalls,1);
	% loop through walls of building
	for w=1:nrWalls
		% todo feed Wall as an argument of interSectPointFromLinePlane
		PlanePoint0 = [WALLS(w,1) WALLS(w,2) WALLS(w,3)];
		PlanePoint1 = [WALLS(w,4) WALLS(w,5) WALLS(w,6)];
		PlanePoint2 = [WALLS(w,7) WALLS(w,8) WALLS(w,9)];
		intSectPoint(w,:) = interSectPointFromLinePlane(lineCoord(1,:), lineCoord(2,:), PlanePoint0, PlanePoint1, PlanePoint2);

		
		% % camera center
		% Cc = LinePoint0;
		% distToIntSectPoint(w) = norm(intSectPoint(w) - Cc)
		% % if the three dimensions have infinite intersection there is no intersection

		% line and wall parallel?
		if(sum(isnan(intSectPoint(w,:))) == 3)
			sprintf('no  intersection found for line %d and wall %d (line and wall are parallel)', i,w)
			dispPointToWalls(w) = inf;
		else
			% calculate distance from intersection point to current wall
			distPointToWalls(w) = distPointToWall(intSectPoint(w,:)', WALLS(w,:));
		end
	end
	%distPointToWalls

	% todo threshold min distances and take of a few the closest one to the Cc	
	% find wall closest to cc
	% [minVal, minIdx] = min(distToIntSectPoint)
	% write cube on intersection point

	[minIspToWallDist, minIspToWallDistIdx] = min(distPointToWalls);
	% write a little cube on the intersection point
	cubeToObj(ispCubesFileName, 1, intSectPoint(minIspToWallDistIdx,:), 0.05);
	% write a line from cc to intersection point
	lineToObj(linesFileName, Cc, intSectPoint(minIspToWallDistIdx,:), 'black');

end

% open the osgviewer
!./o


% write the points lines in obj file 
% fp = fopen(fileName, 'a');
% for i=range1
% 	fprintf(fp, 'p %d\n', i/stepSize);
% end
% fclose(fp);

% alle planes inladen uit .matlab file
