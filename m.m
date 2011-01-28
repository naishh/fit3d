% todo if isp lies within line segment stop evaluating other line segments because they can never have shorter distance

<<<<<<< HEAD
    
%clear;
%close all;
=======
clear;
close all;
>>>>>>> origin/master

% if workspace vars are not loaded
if exist('PcamX') == 0
	disp('load PcamX');
	cd mats
	%load outputVars_scriptComputeCameraMotion.mat
	  %[SkylineX, SkylineY] = getSkyLineMain();
	%load Skylines.mat
	load SkylinesX.mat
	load SkylinesY.mat
	load WALLS.mat
	cd ..
	% load WALL coordinates
end

for(im=1:5)


% flush and instantiate files
linesFileName 		= 'lines.obj';
ispCubesFileName	= ['ispCubes',int2str(im),'.obj'];
fp = fopen(linesFileName   , 'w'); fprintf(fp,'mtllib colors.mtl\n'); fclose(fp);
fp = fopen(ispCubesFileName, 'w'); fclose(fp);


<<<<<<< HEAD
imNr 		= im;
Ccs 		= getCameraCentersFromP(PcamX); Cc = Ccs{imNr};

PcamAbs = getTrajectory3DNorm(invertMotion(normalizePcam(PcamX)));
Cc = PcamAbs(1:3,4,imNr);

=======
imNr 		= 2;
Ccs 		= getCameraCentersFromP(PcamX); Cc = Ccs{imNr};

>>>>>>> origin/master
% determine samplesize and range of skyline pixels
minI = 260; maxI = 1235; stepSize = 5; range1 = minI:stepSize:maxI;
% calc number of datapoints
nDatapoints = (maxI-minI)/stepSize;
nWalls 		= length(WALLS);
ispsPerWall = cell(nWalls, nDatapoints);


% todo pcamX times skylines
% letop dit gaat cumulatiev en werkt nu alleen voor 2e
R = PcamX(:,1:3,imNr); T = PcamX(:,4,imNr);
%- R*(T)
% retrieve 2 coords of line in 3d
SkylinesXYZ = zeros(maxI,3);
% todo optimize
for i=range1
	% maak coord homogeneaus
	%V = [Skylines{imNr}.SkylineX(i);Skylines{imNr}.SkylineY(i);1];
	V = [SkylinesX{imNr}(i);SkylinesY{imNr}(i);1];
	%V = R * -V;
	%V = V + -T;
	SkylinesXYZ(i,:) = V;
	%[Skylines{imNr}.SkylineX(i);Skylines{imNr}.SkylineY(i); 1 ] - (R*T);
end


skylinePixNo = 1;
% loop through skyline pixels
for i=range1
	i
	% TODO:format goed doen

	coord2D = homog22d(SkylinesXYZ(i,:));
<<<<<<< HEAD
	lineCoord = pointsTo3DLine(coord2D, Cc, Kcanon10GOOD, PcamAbs, imNr);
=======
	lineCoord = pointsTo3DLine(coord2D, Cc, Kcanon10GOOD, PcamX, imNr);
>>>>>>> origin/master

	% distToIntSectPoint 	= zeros(nWalls,1);
	intSectPoint 		= zeros(nWalls,3);
	distPointToWalls 	= inf(nWalls,1);
	% loop through walls of building
	for w=1:nWalls
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

	% todo threshold min distances and take of a few the closest one to the Cc	
	% find wall closest to cc
	% [minVal, minIdx] = min(distToIntSectPoint)

	[minIspToWallDist, minIspToWallDistIdx] = min(distPointToWalls);
	% write a little cube on the intersection point
	isp = intSectPoint(minIspToWallDistIdx,:);
	writeObjCube(ispCubesFileName, 1, isp, 0.1);

	% store isps together with closest wall
	ispsPerWall{minIspToWallDistIdx,skylinePixNo} = intSectPoint(minIspToWallDistIdx,:);
	
	% write a line from cc to intersection point
	%writeObjLineThick(linesFileName, Cc, intSectPoint(minIspToWallDistIdx,:),'black',1);
	skylinePixNo = skylinePixNo + 1;
end


% TODO
% % remove zero entries
% ispsPerWallSingle = zeros(1,nDatapoints);
% for wall=1:nWalls
% 	ispsPerWallSingle(:,1) 		= ispsPerWall{wall,:}
% 	ispsPerWallSingleNoZero = ispsPerWallSingle(ispsPerWallSingle~=0);
% 	ispsPerWall2{wall,:} 	= ispsPerWallSingle; 
% end


% adds 2 ground coords wraped arround the ispsPerWall
% this is because the skyline detection doesn't detect the cornerpoints on the ground
ispsPerWall = addGroundCoords(WALLS, ispsPerWall);
writeObjWall('walls.obj', ispsPerWall, 'red',imNr);


% open the osgviewer
%!./o

end;
