function [Xv, Yv] = houghlinesToXY(Houghlines)
% get all X values of all endpoints of vertical houghlines 
Xv = [];
Yv = [];
for i=1:length(Houghlines)
	Xv = [Xv, Houghlines(i).point1(1),Houghlines(i).point2(1)];
	Yv = [Yv, Houghlines(i).point1(2),Houghlines(i).point2(2)];
end
