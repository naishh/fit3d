% get cCorner object
%	these are 'winkelhaken' corner
%
% input
%  	vertical houghlines
%  	horizontal houghlines
%	cornerInlierThreshold
%		the normalised distance to the crossing
%		for example if this is 1/5 then this distance should be 1/5 of the avg of the horizotal and vertical houghline to be an inlier	
% output
%	updated Houghlines with cCorner objects
%
function Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold)

% loop through vertical houghlines
for i=1:length(Houghlines)
	k = 1;
	p1 = Houghlines(i).point1';
	p2 = Houghlines(i).point2';
	% loop through horizontal houghlines
	for j=1:length(HoughlinesRot)
		p3 = HoughlinesRot(j).point1';
		p4 = HoughlinesRot(j).point2';
		[crossing,dist,line1End,line2End] = getLineCrossing(p1,p2,p3,p4);
		% if line segment endpoints are close to crossing 

		% normalise dist to avg line segment length
		dist = dist/((norm(p2-p1)+norm(p4-p3))/2)

		if dist<cornerInlierThreshold
			% store connected corner
			cCorner.vlineOri 		 = [p1,p2];
			cCorner.hlineOri 		 = [p3,p4];
			cCorner.vlineTjointEnd   = line1End; 
			cCorner.hlineTjointEnd   = line2End; 
			cCorner.crossing         = crossing;
			cCorner.dist         	 = dist;
			Houghlines(i).cCorners(k)= cCorner;
			k = k + 1;
		end
	end
end

