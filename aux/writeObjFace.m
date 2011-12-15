function writeObjFace(fileName, ispsPerWall, color)
%colorList = {'white', 'red', 'darkred', 'green', 'blue', 'yellow', 'cyan', 'magenta','white', 'red', 'darkred', 'green'}

[nrWalls, nrPix] = size(ispsPerWall)

% loop through walls
for wall=1:nrWalls
	%color = colorList{wall}; %fprintf(fp, 'usemtl %s\n', color);

	% instantiate file
	fp = fopen(['wall',int2str(wall),'.obj'], 'w');
	fprintf(fp, 'mtllib colors.mtl\n');
	fprintf(fp, 'usemtl %s\n', color);

	foundDataPoint=false;
	nDataPoints  = 0;

	% loop through skyline pixels
	for pix=1:length(ispsPerWall(wall,:))
		dataPoint = ispsPerWall{wall,pix};
		% if dataPoint has a value
		if length(dataPoint)>=3
			foundDataPoint = true;
			fprintf(fp, 'v %d %d %d\n', dataPoint(1),dataPoint(2),dataPoint(3));
			fprintf(fp, 'vt 1 0 0\n');
			nDataPoints = nDataPoints + 1
		end
	end

	% only write a face when there are enough polygons
	if foundDataPoint
		% fprintf(fp, 'v 0 0 0\n');
		% fprintf(fp, 'vt 1 0 0\n');
		% nDataPoints  = nDataPoints + 1;
		% fprintf(fp, 'v 0 0 0\n');
		% fprintf(fp, 'vt 1 0 0\n');
		% nDataPoints  = nDataPoints + 1;
		% connect datapoints to polygon
		fprintf(fp, 'f ');
		for n=1:nDataPoints
			fprintf(fp, ' %d/%d', -n, -n);
		end
		fprintf(fp, '\n\n');
	end
	% todo instead: writeObjFace(fp, -nDataPoints:-1)

	fclose(fp);

end
