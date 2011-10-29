function figBuilding = plotBuilding(Walls, interestingWalls)
figBuilding = figure();
hold on;

% change order of the cornerpoints of the wall so the polygons (walls) are plotted right
WallsNew = [Walls(:,1:3),Walls(:,7:9),Walls(:,10:12),Walls(:,4:6)];

% loop through walls
for wall=1:size(WallsNew,1)
	X = [];
	Y = [];
	Z = [];
	% fill X Y and Z coord seperatelly
	for coord=1:3:12
		X = [X;WallsNew(wall,coord)];
		Y = [Y;WallsNew(wall,coord+1)];
		Z = [Z;WallsNew(wall,coord+2)];
	end
	C = ones(1,4);
	colorSpec = 'y';
	% draw wall
	color1 = 'w';
	if wall==7
		fill3(X,Y,Z,color1);
	elseif wall==9
		fill3(X,Y,Z,color1);
	elseif wall==10
		fill3(X,Y,Z,color1);
	else
		fill3(X,Y,Z,color1);
	end


	hold on;
	%pause;
end


% rotate, somehow doesnt work
%rotateDir = [0 1 0];
%center = [0 0 0];
%rotate(h, rotateDir, 180, center);
