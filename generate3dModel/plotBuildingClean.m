function figBuilding = plotBuilding(Walls, interestingWalls)
figBuilding = figure();
hold on;


% loop through walls
for wall=1:size(Walls,1)
	X = [];
	Y = [];
	Z = [];
	% fill X Y and Z coord seperatelly
	for coord=1:3:12
		X = [X;Walls(wall,coord)];
		Y = [Y;Walls(wall,coord+1)];
		Z = [Z;Walls(wall,coord+2)];
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
