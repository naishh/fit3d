function d = distPointToWall(isp, Wall)
% check wether point lies within polygon then return d=0, els return min dist to line segment

% testcase
% Wall = [100 25 -25 100 25 25 100 -25 25 100 -25 -25]
% isp = [100 -1000 25]'

% define corners c of wall
c1 = [Wall(1);Wall(2);Wall(3)];
c2 = [Wall(4);Wall(5);Wall(6)];
c3 = [Wall(7);Wall(8);Wall(9)];
c4 = [Wall(10);Wall(11);Wall(12)];

% isp
% c1
% c2
% c3
% c4

% cubeFileName = sprintf('cubes_wall_all.obj');
% cubeToObj(cubeFileName, 1, c1, 0.1);
% cubeToObj(cubeFileName, 1, c2, 0.1);
% cubeToObj(cubeFileName, 1, c3, 0.1);
% cubeToObj(cubeFileName, 1, c4, 0.1);

inPolygon = pointInPolygon(isp, c1, c2, c3, c4);

if inPolygon
	%disp('point in polygon!');
	d = 0;
else
	%disp('point not in polygon');
	dist = zeros(4,1);
	dist(1) = distPointToLineSegment(isp, c1, c2);
	dist(2) = distPointToLineSegment(isp, c2, c4);
	dist(3) = distPointToLineSegment(isp, c4, c3);
	dist(4) = distPointToLineSegment(isp, c3, c1);
	[d, dIdx] = min(dist);
end
