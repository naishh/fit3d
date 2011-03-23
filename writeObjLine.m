function writeObjLine(fileName, c1, c2, color)
if exist(fileName) == 0
	fp = fopen(fileName, 'w'); fprintf(fp,'mtllib colors.mtl\n'); fclose(fp);
end

fp = fopen(fileName, 'a');

fprintf(fp, 'usemtl %s\n', color);
fprintf(fp, 'v %d %d %d\n', c1(1), c1(2), c1(3));
fprintf(fp, 'v %d %d %d\n', c2(1), c2(2), c2(3));
fprintf(fp, 'l -2 -1\n');

fclose(fp);
