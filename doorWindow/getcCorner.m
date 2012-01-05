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
	axis square;
	hold on;
	%plotHoughlines(Houghlines,'green');
	%plotHoughlines(HoughlinesRot,'red');
	plotHoughlines(Houghlines,'yellow');
	plotHoughlines(HoughlinesRot,'yellow');
end


% loop through vertical houghlines
for i=1:length(Houghlines)
	k = 1;
	p1 = Houghlines(i).point1';
	p2 = Houghlines(i).point2';
	% loop through horizontal houghlines
	for j=1:length(HoughlinesRot)
		p3 = HoughlinesRot(j).point1';
		p4 = HoughlinesRot(j).point2';
		[crossing,dist,line1,line2] = getLineCrossing(p1,p2,p3,p4);
		% if line segment endpoints are close to crossing 
		if dist<cornerInlierThreshold
			% store connected corner
			cCorner.vlineOri 		 = [p1,p2];
			cCorner.hlineOri 		 = [p3,p4];
			cCorner.vlineTjoint      = line1; 
			cCorner.hlineTjoint      = line2; 
			cCorner.crossing         = crossing;
			%cCorner.dist         	 = dist;

			Houghlines(i).cCorners(k)= cCorner;
			k = k + 1;
		end

		%if plotme
		%	plotHoughlineShort(HoughlinesRot(j),1,'red');
		%end
	end
end

