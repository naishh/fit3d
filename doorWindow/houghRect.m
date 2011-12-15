% calculates the distances from all to all endpoints of the line segments outputed by project2squareHough
load('../project2Normal/Houghlines.mat');
load('../project2Normal/HoughlinesRot.mat');

figure;
hold on;
plotHoughlines(Houghlines,'green');
plotHoughlines(HoughlinesRot,'red');

for j=1:length(Houghlines)
	v1Accu = [];
	v2Accu = [];
	for k=1:length(HoughlinesRot)
		v1 = Houghlines(j).point1;
		v2 = Houghlines(j).point2;
		p1 = HoughlinesRot(k).point1;
		p2 = HoughlinesRot(k).point2;
		v1D = min(euclideanDist(v1,p1), euclideanDist(v1,p2));
		v2D = min(euclideanDist(v2,p1), euclideanDist(v2,p2));
		v1Accu = [v1Accu, v1D];
		v2Accu = [v2Accu, v2D];
	end
	[v1min, idxV1min]= min(v1Accu);
	[v2min, idxV2min]= min(v2Accu);
	Houghlines(j).point1MinDist    = v1min;
	Houghlines(j).point1MinDist    = v1min;
	Houghlines(j).point2MinDist    = v2min;
	Houghlines(j).point2MinDistIdx = idxV2min;
end

[vals, idxSort] = sort([Houghlines.point1MinDist])

nrCorners = 4;
idxSort = idxSort(1:nrCorners)

plotHoughlines(Houghlines(idxSort),'blue')
