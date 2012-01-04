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
		cCorner.vlineOri 		 = [p3b, p3];
		cCorner.hlineOri 		 = [p1,p2];

		p1 = HoughlinesRot(j).point1';
		p2 = HoughlinesRot(j).point2';
		% get midpoints of line
		midPointp1p2 = (p1+p2)/2; midPointp3p3b = (p3+p3b)/2;
		% compare x coord of midpoints to determine direction of horizontal relative to vertical
		if midPointp3p3b(1)>=midPointp1p2(1)
			HdirectionRight = 1;
			% TODO maybe p2..
			cCorner.hlineTjoint = p2;
		else
			HdirectionRight = 0;
			cCorner.hlineTjoint = p1;
		end
		% get distance both points with horizontal line segment
		[dist1, crossing1] = distAndIntersectionPointLineSegment2d(p3, p1, p2);
		[dist2, crossing2] = distAndIntersectionPointLineSegment2d(p3b, p1, p2);
		if dist1<cornerInlierThreshold
			% store connected corner
			cCorner.crossing         = crossing1;
			cCorner.vlineTjoint      = [p3b,crossing]; 
			cCorner.VdirectionUp     = 0;
			cCorner.HdirectionRight  = HdirectionRight;
			Houghlines(i).cCorners(k)= cCorner;
			k = k + 1;
		end
		if dist2<cornerInlierThreshold
			cCorner.crossing         = crossing2;
			cCorner.vlineTjoint      = [p3,crossing]; 
			cCorner.VdirectionUp 	 = 1;
			cCorner.HdirectionRight  = HdirectionRight;
			Houghlines(i).cCorners(k)= cCorner;
			k = k + 1;
		end
		% add crossing
		cCorner.hlineTjoint = [cCorner.hlineTjoint,cCorner.crossing];

		if plotme
			plotHoughlineShort(HoughlinesRot(j),1,'red');
		end
	end
end

