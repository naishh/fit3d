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

%fullFilename = [Files.dir,Files.files(1).name];

% clear files
fp = fopen(linesFileName , 'w'); fprintf(fp,'mtllib colors.mtl\n'); fclose(fp);
fp = fopen(ispCubesFileName, 'w'); fprintf(fp,'mtllib colors.mtl\n'); fclose(fp);

% load WALL coordinates
load('mats/WALLS.mat')

% determine samplesize and range of skyline pixels
minI = 900; maxI = 1000; stepSize = 10;
range1 = minI:stepSize:maxI;

updatedWallCoords = cell(maxI, 3);

imNr = 1;

Ccs = getCameraCentersFromP(PcamX)


% camera center
Cc = Ccs{imNr};

% retrieve 2 coords of line in 3d
% todo pcamX times skylines

% letop dit gaat cumulatiev en werkt nu alleen voor 2e
R = PcamX(:,1:3,imNr);
T = PcamX(:,4,imNr);

SkylinesXYZ = zeros(maxI,3);
% todo optimize
for i=range1
	R = PcamX(:,1:3,imNr);
	T = PcamX(:,4,imNr);
	V = [Skylines{imNr}.SkylineX(i);Skylines{imNr}.SkylineY(i);1]
	%V = R * -V;
	%V = V + -T;
	SkylinesXYZ(i,:) = V;
	%[Skylines{imNr}.SkylineX(i);Skylines{imNr}.SkylineY(i); 1 ] - (R*T);
end

%- R*(T)

j = 1;
% loop through skyline pixels
for i=range1
	%clear file
	fp = fopen('inpolygon.obj', 'w'); fclose(fp);
	i
	% TODO:format goed doen
	lineCoord = pointsTo3DLine(homog22d(SkylinesXYZ(i,:)), Cc, Kcanon10GOOD);

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
	isp = intSectPoint(minIspToWallDistIdx,:);
	cubeToObj(ispCubesFileName, 1, isp, 0.05);

	updatedWallCoords{j} = intSectPoint(minIspToWallDistIdx,:)
	
	% write a line from cc to intersection point
	lineToObj(linesFileName, Cc, intSectPoint(minIspToWallDistIdx,:), 'black');

	j = j + 1;
end

% generate Buildings_colored.obj from .mat file
% STRUCTURED every wall independend index
% update with given wall index and updatetWallCoords
%

wallToObj('walls.obj', WALLS, updatedWallCoords, 7, 'black')


% open the osgviewer
%!./o


% write the points lines in obj file 
% fp = fopen(fileName, 'a');
% for i=range1
% 	fprintf(fp, 'p %d\n', i/stepSize);
% end
% fclose(fp);

% alle planes inladen uit .matlab file
