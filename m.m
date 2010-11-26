close all;
fileName = 'outputM.obj';
%cd ../FIT3D_online_17082010
%FIT3D_setup
%cd ../git/mats

cd mats
load outputVars_scriptComputeCameraMotion.mat
  %[SkylineX, SkylineY] = getSkyLineMain();
load outputVars_Skyline.mat
cd ..


% todo make camera center depended of translation in P
P1 = PcamX(:,:,1) % = [I,0]
fullFilename = [Files.dir,Files.files(1).name]
%Im = imread(fullFilename);
%figure; imshow(Im);

%figure; hold on;

% clear file
fp = fopen(fileName, 'w'); fclose(fp);
fp = fopen('cubes.obj', 'w'); fclose(fp);

load mats/WALLS
% loop through skyline pixels
load('mats/WALLS.mat')

maxI = 800;
stepSize = 20;
range1 = 100:stepSize:maxI;
for i=range1
	% the 2d pixel coordinates of the skyline
	xy = [SkylineX(i);SkylineY(i)];

	CC = [0;0;0];
	lineCoord = pointsTo3DLine(xy, CC, Kcanon10GOOD)
	X = lineCoord(:,1); Y = lineCoord(:,2); Z = lineCoord(:,3);
	% plot in matlab
	%plot3(X,Y,Z)
	%xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis')
	
	XYZtoObj(fileName, X,Y,Z, i/stepSize);

	LinePoint0 = lineCoord(1,:);
	LinePoint1 = lineCoord(2,:);

	nrWalls = length(WALLS);
	% define a distance to the intersection point for every wall
	distToIntSectPoint 	= zeros(nrWalls,1);
	intSectPoint 		= zeros(nrWalls,3);
	% loop through walls of building
	for w=1:nrWalls
		Wall = WALLS(w,:);
		% todo feed Wall as an argument of interSectPointFromLinePlane
		PlanePoint0 = [Wall(1) Wall(2) Wall(3)];
		PlanePoint1 = [Wall(4) Wall(5) Wall(6)];
		PlanePoint2 = [Wall(7) Wall(8) Wall(9)];
		intSectPoint(w,:) = interSectPointFromLinePlane(LinePoint0, LinePoint1, PlanePoint0, PlanePoint1, PlanePoint2);
		% camera center
		CC = LinePoint0;
		distToIntSectPoint(w) = norm(intSectPoint(w) - CC)
		% if the three dimensions have infinite intersection there is no intersection
		if(sum(isnan(intSectPoint(w,:))) == 3)
			sprintf('no  intersection found for line %d and wall %d', i,w)
		else
			%sprintf('yes intersection found for line %d and wall %d', i,w)
			%cubeFileName = sprintf('cubes_wall%d.obj',w)
		end
	end
	% find wall closest to cc
	[minVal, minIdx] = min(distToIntSectPoint)
	% write cube on intersection point
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
