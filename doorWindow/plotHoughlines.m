function Houghlines = plotHoughlines(Houghlines, plotme)
for k = 1:length(Houghlines)
	k
	xy = [Houghlines(k).point1; Houghlines(k).point2];
	plotHoughline(xy, plotme,'green')

	% Determine the endpoints of the longest line segment
	len = norm(Houghlines(k).point1 - Houghlines(k).point2);

	% store length
	Houghlines(k).len = len;
	Houghlines(k).theta
end
