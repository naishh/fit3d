function plotcCorners(Houghlines,HoughlinesRot)
% plot cCorners nicely
for i=1:length(Houghlines)
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		% type is upper right l shape
		%if cCorner.HdirectionRight == 0 && cCorner.VdirectionUp == 1
		%	% plot vertical line
		%	plotHoughlineShort(Houghlines(i),1, 'black');
		%	% plot horizontally connected lines
		%	plotcCorner(i, k, Houghlines, HoughlinesRot, 'red');
		%elseif cCorner.HdirectionRight == 0 && cCorner.VdirectionUp == 0
		%	% plot vertical line
		%	plotHoughlineShort(Houghlines(i),1, 'black');
		%	% plot horizontally connected lines
		%	plotcCorner(i, k, Houghlines, HoughlinesRot, 'green');
		%end

		plotHoughlineShort(Houghlines(i),1, 'black');
		plotcCorner(i, k, Houghlines, HoughlinesRot, 'green');
		X = [cCorner.vlineEnd(1),cCorner.crossing(1),cCorner.hlineEnd(1)];
		Y = [cCorner.vlineEnd(2),cCorner.crossing(2),cCorner.hlineEnd(2)];
		plot(X, -Y, '-k');
		pause;
	end
end

