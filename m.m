close all;
fileName = 'outputM.obj';
% cd mats
% load outputVars_scriptComputeCameraMotion.mat
%   %[SkylineX, SkylineY] = getSkyLineMain();
% load outputVars_Skyline.mat
% cd ..

% todo make camera center depended of translation in P
P1 = PcamX(:,:,1) % = [I,0]
fullFilename = [Files.dir,Files.files(1).name]

% clear files
fp = fopen(fileName, 'w'); fclose(fp);
fp = fopen('cubes_wall_all.obj', 'w'); fclose(fp);

% load WALL coordinates
load('mats/WALLS.mat')

% determine samplesize and range of skyline pixels
minI = 100; maxI = 1300; stepSize = 5;
range1 = minI:stepSize:maxI;
% loop through skyline pixels
for i=range1
	% camera center
	CC = [0;0;0];
	% retrieve 2 coords of line in 3d
	lineCoord = pointsTo3DLine([SkylineX(i);SkylineY(i)], CC, Kcanon10GOOD);
	X = lineCoord(:,1); Y = lineCoord(:,2); Z = lineCoord(:,3);
	
	% write line to obj file
	XYZtoObj(fileName, X,Y,Z, i/stepSize);

	nrWalls = length(WALLS);
	distToIntSectPoint 	= zeros(nrWalls,1);
	intSectPoint 		= zeros(nrWalls,3);
	distPointToWalls 	= zeros(nrWalls,1);
	% loop through walls of building
	for w=1:nrWalls
		Wall = WALLS(w,:);
		% todo feed Wall as an argument of interSectPointFromLinePlane
		PlanePoint0 = [Wall(1) Wall(2) Wall(3)];
		PlanePoint1 = [Wall(4) Wall(5) Wall(6)];
		PlanePoint2 = [Wall(7) Wall(8) Wall(9)];
		intSectPoint(w,:) = interSectPointFromLinePlane(lineCoord(1,:), lineCoord(2,:), PlanePoint0, PlanePoint1, PlanePoint2);

		
		% % camera center
		% CC = LinePoint0;
		% distToIntSectPoint(w) = norm(intSectPoint(w) - CC)
		% % if the three dimensions have infinite intersection there is no intersection
		if(sum(isnan(intSectPoint(w,:))) == 3)
			sprintf('no  intersection found for line %d and wall %d', i,w)
		else
			%sprintf('yes intersection found for line %d and wall %d', i,w)
			distPointToWalls(w) = distPointToWall(intSectPoint(w,:)', Wall);
			%cubeFileName = sprintf('cubes_wall%d.obj',w)
		end
	end
	% find wall closest to cc
	% [minVal, minIdx] = min(distToIntSectPoint)
	% write cube on intersection point

	[minVal, minIdx] = min(distPointToWalls)
	cubeFileName = sprintf('cubes_wall_all.obj');
	cubeToObj(cubeFileName, 1, intSectPoint(minIdx,:), 0.05);
end

% write lines in obj file 
fp = fopen(fileName, 'a');
for i=range1
	fprintf(fp, 'p %d\n', i/stepSize);
end
fclose(fp);

% alle planes inladen uit .matlab file
