% config
close all;
windowsPlot = 1;

clear Houghlines3dWall
load '../houghlines3d/Houghlines3dWall.mat'


if windowsPlot
	figure;
	hold on;
	plotBuilding();
end

% loop through different walls
for w=1:length(Houghlines3dWall)
	%w = 10
	w


	% calc average
	l = length(Houghlines3dWall{w})
	pause;
	if l > 1
		disp('l>1');

		point1Tot = 0;
		point2Tot = 0;

		% loop through houghlines of one wall
		for i=2:l
			point1 = Houghlines3dWall{w}(i).point1;
			point2 = Houghlines3dWall{w}(i).point2;

			X = [point1(1), point2(1)]
			Y = [point1(2), point2(2)]
			Z = [point1(3), point2(3)]
			plot3(X, Y, Z, '-b');

			point1Tot = point1Tot + point1;
			point2Tot = point2Tot + point2;
		end

		point1Avg = point1Tot / (l-1) 
		point2Avg = point2Tot / (l-1) 

		if windowsPlot
			% matlab plot for windows computers
			X = [point1Avg(1), point2Avg(1)]
			Y = [point1Avg(2), point2Avg(2)]
			Z = [point1Avg(3), point2Avg(3)]
			plot3(X, Y, Z, '-r');
		end
	end
end
