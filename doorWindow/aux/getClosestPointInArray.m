function closestPoint = getClosestPointInArray(winXY, PointArray)
	minDist = intmax;
	for i=1:size(PointArray,1)
		d = euclideanDist(winXY,PointArray(i,:));
		if d < minDist 
			closestPoint = PointArray(i,:);
			minDist = d;
		end
	end
end
