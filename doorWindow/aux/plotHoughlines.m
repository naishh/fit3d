function Houghlines = plotHoughlines(Houghlines,colorStr)
for k = 1:length(Houghlines)
	plotme = 1;
	xy = [Houghlines(k).point1; Houghlines(k).point2];
	plotHoughline(xy,plotme,colorStr);
end
