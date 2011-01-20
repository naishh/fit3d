function wallToObj(fileName, ispsPerWall, color)
%colorList = {'white', 'red', 'darkred', 'green', 'blue', 'yellow', 'cyan', 'magenta','white', 'red', 'darkred', 'green'}

[nrWalls, nrPix] = size(ispsPerWall)

for wall=1:nrWalls
	%color = colorList{wall}; %fprintf(fp, 'usemtl %s\n', color);

	fp = fopen(['wall',int2str(wall),'.obj'], 'w');
	fprintf(fp, 'mtllib colors.mtl\n');
	fprintf(fp, 'usemtl %s\n', color);

	foundDataPoint=false;
	nrDataPoints  = 0;
	for pix=1:length(ispsPerWall(wall,:))
		dataPoint = ispsPerWall{wall,pix};
		% if dataPoint  has value
		if length(dataPoint)>=3
			foundDataPoint=true;
			ispsPerWall{wall,pix}
			% print 3 times so there is always a face with minimum of three vertices
			fprintf(fp, 'v %d %d %d\n', dataPoint(1),dataPoint(2),dataPoint(3));
			fprintf(fp, 'vt 1 0 0\n');
			nrDataPoints = nrDataPoints + 1
		end

	end

	if foundDataPoint
		% fprintf(fp, 'v 0 0 0\n');
		% fprintf(fp, 'vt 1 0 0\n');
		% nrDataPoints  = nrDataPoints + 1;
		% fprintf(fp, 'v 0 0 0\n');
		% fprintf(fp, 'vt 1 0 0\n');
		% nrDataPoints  = nrDataPoints + 1;
		% connect datapoints to polygon
		fprintf(fp, 'f ');
		for n=1:nrDataPoints
			fprintf(fp, ' %d/%d', -n, -n);
		end
		fprintf(fp, '\n\n');
	end

	fclose(fp);

end


%fprintf(fp, 'usemtl black\n\n', color);

