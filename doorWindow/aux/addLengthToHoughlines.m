function Houghlines = addLengthToHoughlines(Houghlines)
for k = 1:length(Houghlines)
	len = norm(Houghlines(k).point1 - Houghlines(k).point2);
	Houghlines(k).len = len;
end
