function wallToObj(fileName, WALLS, updatedWallCoords, betweenWallNo, replaceWallCoord, color)
fp = fopen(fileName, 'w');
fprintf(fp, 'mtllib colors.mtl\n');
fprintf(fp, 'usemtl %s\n', color);

dataPoints = length(updatedWallCoords)

% print  first two lowest coords of building
m=3;
fprintf(fp, 'v 11.799408 -1.842093 30.10915\n');
fprintf(fp, 'vt 1 0 0\n');
fprintf(fp, 'v -1.366259 -2.812347 11.149166\n');
fprintf(fp, 'vt 1 0 0\n');

fprintf(fp, 'v -1.339032 1.182091 10.940056\n');
fprintf(fp, 'vt 1 0 0\n');
%fprintf(fp, 'v 11.826635 2.152345 29.900041\n');
%fprintf(fp, 'vt 1 0 0\n');




for k=1:dataPoints-1
	fprintf(fp, 'v %d %d %d\n', updatedWallCoords(k,1), updatedWallCoords(k,2), updatedWallCoords(k,3));
	fprintf(fp, 'vt 1 0 0\n');
end

fprintf(fp, 'f ');

for n=1:dataPoints-1 + m
	fprintf(fp, ' %d/%d', -n, -n);
end

fprintf(fp, '\n\n');
%fprintf(fp, 'usemtl black\n\n', color);

fclose(fp);
