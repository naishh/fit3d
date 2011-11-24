function WallsPc = generateWallsFromCornerPoints(X,Z,yGround,yAir,bConnectLastToFirstWall)
	l = length(X);

	% generate walls of coornerpoints
	if bConnectLastToFirstWall
		WallsPc = zeros(length(X),12);
	else
		WallsPc = zeros(length(X)-1,12);
	end
	for i=1:length(X)-1
		i
		% pc = pointcloud
		WallsPc(i,:) = [X(i),yGround,Z(i),	X(i+1),yGround,Z(i+1),	X(i),yAir,Z(i),	 X(i+1),yAir,Z(i+1)];
	end
	if bConnectLastToFirstWall
		% generate last wall (last to first corner{)
		WallsPc(l,:) = [X(1),yGround,Z(1),	X(l),yGround,Z(l),	X(1),yAir,Z(1),		X(l),yAir,Z(l)];
	end

	plotBuilding(WallsPc);
end
