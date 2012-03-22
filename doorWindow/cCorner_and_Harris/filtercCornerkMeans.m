function Houghlines = filtercCornerkMeans(Houghlines)
c = 1;
for i=1:length(Houghlines)
	fprintf('%d percent done \n', i/length(Houghlines)*100);
	for k=1:length(Houghlines(i).cCorners)
		midPoints(c,:) = [Houghlines(i).cCorners(k).windowMidpointX, Houghlines(i).cCorners(k).windowMidpointY];
		c = c + 1;
	end
end

[dummy, midPointsClustered] = kmeans(midPoints, 30)

for i=1:size(midPointsClustered,1)
	i
	plot(midPointsClustered(i,1), midPointsClustered(i,2), 'k*','linewidth', 5, 'MarkerSize',10 );
	hold on;
end


