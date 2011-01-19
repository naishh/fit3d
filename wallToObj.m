%function wallToObj(fileName, WALLS, updatedWallCoords, betweenWallNo, replaceWallCoord, color)
function wallToObj(fileName, ispsPerWall, color)

fp = fopen(fileName, 'w');
fprintf(fp, 'mtllib colors.mtl\n');
fprintf(fp, 'usemtl %s\n', color);

%dataPoints = length(updatedWallCoords)


[nrWalls, nrPix] = size(ispsPerWall)

for wall=1:nrWalls
	foundDataPoint=false;
	nrDataPoints  = 0;
	for pix=1:length(ispsPerWall(wall,:))
		dataPoint = ispsPerWall{wall,pix};
		% if dataPoint  has value
		if length(dataPoint)>=3
			foundDataPoint=true;
			ispsPerWall{wall,pix}
			fprintf(fp, 'v %d %d %d\n', dataPoint(1),dataPoint(2),dataPoint(3));
			fprintf(fp, 'vt 1 0 0\n');
			nrDataPoints = nrDataPoints + 1
		end

	end

	if foundDataPoint
		fprintf(fp, 'v 0 0 0\n');
		fprintf(fp, 'vt 1 0 0\n');
		nrDataPoints  = nrDataPoints + 1;
		fprintf(fp, 'v 0 0 0\n');
		fprintf(fp, 'vt 1 0 0\n');
		nrDataPoints  = nrDataPoints + 1;
		% connect datapoints to polygon
		fprintf(fp, 'f ');
		for n=1:nrDataPoints
			fprintf(fp, ' %d/%d', -n, -n);
		end
		fprintf(fp, '\n\n');
	end


end


%fprintf(fp, 'usemtl black\n\n', color);

fclose(fp);
