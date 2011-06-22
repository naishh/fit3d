% this file calculates the average of a bunch houghlines belonging to a wall
% to eventualy calc and adapt to the height of the building

clear Houghlines3dWall
clear HeightBuildingWall
load Houghlines3dWall
load Walls

WallsNew = Walls;
plotBuilding(Walls, []);


interestingWalls = [7, 9, 10];

% all walls
%for wall = 1:length(Houghlines3dWall)
for i = 1:length(interestingWalls)
	wall = interestingWalls(i);
	sum = [0 0 0];
	wall
	nrHoughlines = length(Houghlines3dWall{wall});
	for h = 2:nrHoughlines
		Houghlines3dWall{wall}(h).point1+Houghlines3dWall{wall}(h).point2;
		sum = sum + Houghlines3dWall{wall}(h).point1+Houghlines3dWall{wall}(h).point2;
		%pause
	end
	if nrHoughlines>=2
		HeightBuildingWall{wall}=sum/((nrHoughlines-1)*2);
		% plot a cross on the average height
		plot3(HeightBuildingWall{wall}(1),HeightBuildingWall{wall}(2),HeightBuildingWall{wall}(3),'b+', 'LineWidth', 2);
	end
			

	% calc dist to bottom side of wall

	% average of houghlines 
	p3 = HeightBuildingWall{wall};
	% bottom line
	p1 = Walls(wall,1:3);
	p2 = Walls(wall,4:6);
	% hold on;
	% plot3(p1(1),p1(2),p1(3), 'b+');
	% pause;
	% plot3(p2(1),p2(2),p2(3), 'b+');
	d = distPointToLineSegment(p3,p1,p2)

	p1 = p1 - [0, d, 0]
	p2 = p2 - [0, d, 0]
	hold on;
	plot3([p1(1),p2(1)],[p1(2),p2(2)],[p1(3),p2(3)], 'r-', 'LineWidth',2);

	% update wall
	WallsNew(wall,7:9) = p1;
	WallsNew(wall,10:12) = p2;

	%pause;

end


figure;
plotBuilding(Walls, interestingWalls)
hold on;
plotBuilding2(WallsNew, interestingWalls)


