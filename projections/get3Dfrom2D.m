% returns the coord in 3d and the belongig wall
function [coord3D, minIspToWallDistIdx] = get3Dfrom2D(coord2D, imNr, PcamAbs, Kcanon10GOOD, WALLS, wallNo)

Cc 			= PcamAbs(:,4,imNr);
nWalls 		= length(WALLS);
	
projectionLine = getProjectionLine(coord2D, Cc, Kcanon10GOOD, PcamAbs, imNr);
plotProjectionLine(projectionLine, 'r-')
pause;


% distToIntSectPoint 	= zeros(nWalls,1);
intSectPoint 		= zeros(nWalls,3);
distPointToWalls 	= inf(nWalls,1);

% if no wallNo set
if (wallNo==0)
	% loop through walls of building
	for w=1:nWalls
		PlanePoint0 = [WALLS(w,1) WALLS(w,2) WALLS(w,3)];
		PlanePoint1 = [WALLS(w,4) WALLS(w,5) WALLS(w,6)];
		PlanePoint2 = [WALLS(w,7) WALLS(w,8) WALLS(w,9)];
		intSectPoint(w,:) = interSectPointFromLinePlane(projectionLine(1,:), projectionLine(2,:), PlanePoint0, PlanePoint1, PlanePoint2);

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
else % associated wall is known
	w = wallNo
	PlanePoint0 = [WALLS(w,1) WALLS(w,2) WALLS(w,3)];
	PlanePoint1 = [WALLS(w,4) WALLS(w,5) WALLS(w,6)];
	PlanePoint2 = [WALLS(w,7) WALLS(w,8) WALLS(w,9)];
	intSectPoint(w,:) = interSectPointFromLinePlane(projectionLine(1,:), projectionLine(2,:), PlanePoint0, PlanePoint1, PlanePoint2);
	distPointToWalls(w) = distPointToWall(intSectPoint(w,:)', WALLS(w,:));
	minIspToWallDistIdx = wallNo
end

distPointToWalls


% write a little cube on the intersection point
isp = intSectPoint(minIspToWallDistIdx,:);
%writeObjCube(ispCubesFileName, 1, isp, 0.1);

% store isps together with closest wall
%ispsPerWall{minIspToWallDistIdx,skylinePixNo} = intSectPoint(minIspToWallDistIdx,:);

coord3D = isp;
