close all;
load 3dObjModels/Walls.mat

% change order of the cornerpoints of the wall
WallsNew = [WALLS(:,1:3),WALLS(:,7:9),WALLS(:,10:12),WALLS(:,4:6)]

% loop through walls
for wall=1:12
	X = []
	Y = []
	Z = []
	% fill X Y and Z coord seperatelly
	for coord=1:3:12
		X = [X;WallsNew(wall,coord)]
		Y = [Y;WallsNew(wall,coord+1)]
		Z = [Z;WallsNew(wall,coord+2)]
	end
	C = ones(1,4)
	fill3(X,Y,Z,C)
	hold on;
end


