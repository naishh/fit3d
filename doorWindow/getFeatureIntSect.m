% projects line endpoints of vertical lines to the horizontal lines
% if the tjerkDistance is lesser then a threshold
% it stores the projection (crossing) coordinate 
%
% input
%  vertical houghlines
%  horizontal houghlines
% output
%
function [crossingAccu,imFeatureIntSect] = getFeatureIntSect(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme)
% TODO NIET HARD CODED::
imFeatureIntSect = zeros(508,368); 

if plotme
	figure;
	axis square;
	hold on;
	plotHoughlines(Houghlines,'green');
	plotHoughlines(HoughlinesRot,'red');
end

vertexAccu = [];
crossingAccu = [];

for j=1:length(Houghlines)
	v1 = Houghlines(j).point1';
	v2 = Houghlines(j).point2';
	vertexAccu = [vertexAccu, v1, v2];
end

for i=1:length(vertexAccu)
	p3 = vertexAccu(:,i);

	for j=1:length(HoughlinesRot)
		p1 = HoughlinesRot(j).point1';
		p2 = HoughlinesRot(j).point2';
		if plotme
			plotHoughlineShort(HoughlinesRot(j),1,'black');
		end
		% TODO crossing goede val
		[dist, crossing] = distAndIntersectionPointLineSegment2d(p3, p1, p2);
		% lower than the maximum distance between two line segment endpoints
		if dist<cornerInlierThreshold
			if plotme
				plot(p3(1), -p3(2), 'r*');
				plot(crossing(1),-crossing(2), 'r+','MarkerSize', 10);
				axis equal;
			end
			%TODO evt -dist als waarde 
			%TODO rounden is info verlies, interpoleren vanuit crossingAccu?
			imFeatureIntSect(round(crossing(2)),round(crossing(1))) = 1;
			%figure(2);imshow(imFeatureIntSect); figure(1);
			crossingAccu = [crossingAccu, crossing];
		end
	end
end

