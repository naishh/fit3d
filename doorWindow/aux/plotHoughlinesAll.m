function Houghlines = plotHoughlinesAll(imHeight, Houghlines, HoughlinesRot)
%for k = 1:length(Houghlines)
%	plotme = 1;
%	len = norm(Houghlines(k).point1 - Houghlines(k).point2);
%	Houghlines(k).len = len;
%	xy = [Houghlines(k).point1; Houghlines(k).point2];
%	plotHoughline(xy,plotme,colorStr);
%end
plotme = 1;
for k = 1:length(Houghlines)
	xy = [Houghlines(k).point1; Houghlines(k).point2];
	plotHoughline(xy, plotme,'green');
end
for k = 1:length(HoughlinesRot)
	% TODO get xy from Theta(..) above, calc as matrix
	xy = [invertCoordFlipY(HoughlinesRot(k).point1,imHeight); invertCoordFlipY(HoughlinesRot(k).point2,imHeight)];
	% save inverted coord on HoughlinesRot
	HoughlinesRot(k).point1 = xy(1,:); HoughlinesRot(k).point2 = xy(2,:);
	plotHoughline(xy, plotme,'red')
end
