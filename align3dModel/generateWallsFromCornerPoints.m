function WallsPc = generateWallsFromCornerPoints(X,Z,yGround,yAir)
	l = length(X);

	% generate walls of coornerpoints
	WallsPc = zeros(length(X),12);
	for i=1:length(X)-1
		% pc = pointcloud
		WallsPc(i,:) = [X(i),yGround,Z(i),	X(i+1),yGround,Z(i+1),	X(i),yAir,Z(i),	 X(i+1),yAir,Z(i+1)];
	end
	% generate last wall (last to first corner{)
	WallsPc(l,:) = [X(1),yGround,Z(1),	X(l),yGround,Z(l),	X(1),yAir,Z(1),		X(l),yAir,Z(l)];

	plotBuilding(WallsPc);
end
