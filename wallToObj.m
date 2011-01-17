function wallToObj(fileName, WALLS, updatedWallCoords, betweenWallNo, replaceWallCoord, color)
fp = fopen(fileName, 'w');
fprintf(fp, 'mtllib colors.mtl\n');
fprintf(fp, 'usemtl %s\n', color);

for i=1:length(WALLS)
	dataPoints = length(WALLS(i,:))/3;

	for j=1:3:length(WALLS)
		% check if j has an alement that is in replaceWallCoord
		% [1,4] are replaced
		if (i==betweenWallNo && sum(((j+2)/3)==replaceWallCoord)>=1)
			disp('skip')
			for k=1:length(updatedWallCoords)-1
				fprintf(fp, 'v %d %d %d\n', updatedWallCoords(k,1), updatedWallCoords(k,2), updatedWallCoords(k,3));
				fprintf(fp, 'vt 1 0 0\n');
			end
			dataPoints = dataPoints+length(updatedWallCoords);
		else
			fprintf(fp, 'v %d %d %d\n', WALLS(i,j), WALLS(i,j+1), WALLS(i,j+2));
			fprintf(fp, 'vt 1 0 0\n');
		end
	end


	fprintf(fp, 'f ');

	for n=1:dataPoints 
		fprintf(fp, ' %d/%d', -n, -n);
	end

	fprintf(fp, '\n\n');
	%fprintf(fp, 'usemtl black\n\n', color);


end
fclose(fp);
