% scales points in houghlines
% also inverts Y
function Houghlines = scaleHoughlines(Houghlines,scale,xOffset);
for i=1:length(Houghlines)
	Houghlines(i).point1 = Houghlines(i).point1 * scale;
	Houghlines(i).point2 = Houghlines(i).point2 * scale;
	% add Y coord to prevent negative values
	Houghlines(i).point1 = Houghlines(i).point1 + [0, xOffset];
	Houghlines(i).point2 = Houghlines(i).point2 + [0, xOffset];
end
