function closestPoint = getClosestPointInArray(winXY, PointArray)
	minDist = intmax;
	for i=1:length(PointArray)
		d = euclideanDist(winXY,PointArray(i,:));
		if d < minDist 
			closestPoint = PointArray(i,:);
			minDist = d;
		end
	end
end
