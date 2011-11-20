% loads the letter T into Houghlines3d{1}
clear Houghlines3d
clear Point
% the letter T on wall 4 in coords

Point{1} = [2 3 5];
Point{2} = [2 3 0];
Point{3} = [2 2 0];
Point{4} = [2 2 1];
Point{5} = [2 0 1];
Point{6} = [2 0 2];
Point{7} = [2 2 2];
Point{8} = [2 2 5];

%connect the dots
for i=1:length(Point)-1
	Houghlines3d{1}(i).point1 = Point{i}
	Houghlines3d{1}(i).point2 = Point{i+1}
end
