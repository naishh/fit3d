function Houghlines = plotHoughlines(Houghlines)
for k = 1:length(Houghlines)
	plotme = 1;
	len = norm(Houghlines(k).point1 - Houghlines(k).point2);
	Houghlines(k).len = len;
	xy = [Houghlines(k).point1; Houghlines(k).point2];
	plotHoughline(xy,plotme,'red');
end
