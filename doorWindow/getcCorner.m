% projects line endpoints of vertical lines to the horizontal lines
% if the cornerInlierThreshold is lesser then a threshold
% it stores the projection (crossing) coordinate and some idxes
%
% input
%  vertical houghlines
%  horizontal houghlines
% output
%
function Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme)

if plotme
	figure;
	axis square;
	hold on;
	plotHoughlines(Houghlines,'green');
	plotHoughlines(HoughlinesRot,'red');
end



% loop through vertical houghlines
for i=1:length(Houghlines)
	k = 1;
	p3 = Houghlines(i).point1';
	p3b = Houghlines(i).point2';
	% loop through horizontal houghlines
	for j=1:length(HoughlinesRot)
		p1 = HoughlinesRot(j).point1';
		p2 = HoughlinesRot(j).point2';
		if plotme
			plotHoughlineShort(HoughlinesRot(j),1,'black');
		end
		% get distance both points with horizontal line segment
		[dist1, crossing1] = distAndIntersectionPointLineSegment2d(p3, p1, p2);
		[dist2, crossing2] = distAndIntersectionPointLineSegment2d(p3b, p1, p2);
		if dist1<cornerInlierThreshold
			% store connected corner
			cCorner.crossing         = crossing1;
			cCorner.HoughlineRotIdx = j;
			cCorner.VdirectionUp     = 1;
			Houghlines(i).cCorners(k) = cCorner;
			k = k + 1;
		end
		if dist2<cornerInlierThreshold
			cCorner.crossing         = crossing2;
			cCorner.HoughlineRotIdx = j;
			cCorner.VdirectionUp = 0;
			Houghlines(i).cCorners(k) = cCorner;
			k = k + 1;
		end
	end
end

