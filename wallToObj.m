function wallToObj(fileName, WALLS, updatedWallCoords, betweenWallNo, color)
fp = fopen(fileName, 'w');
fprintf(fp, 'mtllib colors.mtl\n');
fprintf(fp, 'usemtl %s\n', color);

for i=1:length(WALLS)
	dataPoints = length(WALLS(i,:))/3;

	for j=1:3:length(WALLS)
		fprintf(fp, 'v %d %d %d\n', WALLS(i,j), WALLS(i,j+1), WALLS(i,j+2));
		fprintf(fp, 'vt 1 0 0\n')
	end

	if (i==betweenWallNo)
		for k=1:length(updatedWallCoords)
			fprintf(fp, 'v %d %d %d\n', updatedWallCoords{k}, updatedWallCoords{k+1}, updatedWallCoords{k+2});
			fprintf(fp, 'vt 1 0 0\n')
		end
		dataPoints = dataPoints+length(updatedWallCoords)
	end

	fprintf(fp, 'f ');

	for n=1:dataPoints 
		fprintf(fp, ' %d/%d', -n, -n);
	end

	fprintf(fp, '\n\n');
	%fprintf(fp, 'usemtl black\n\n', color);


end
fclose(fp);
