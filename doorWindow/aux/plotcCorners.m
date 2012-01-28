function plotcCorners(Houghlines, HoughlinesRot, plotMode, pauseMode)
for i=1:length(Houghlines)
	for k=1:length(Houghlines(i).cCorners)
		i
		k
		cCorner = Houghlines(i).cCorners(k);
		plotcCorner(cCorner, plotMode, pauseMode);
	end
	% use for overzichtelijk plotting (one cCorner per houghline)
	%for k=1:min(length(Houghlines(i).cCorners),1)
	%	cCorner = Houghlines(i).cCorners(1);
	%	plotcCorner(cCorner, plotMode);
	%end
end
