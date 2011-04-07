function writeObjLineThick(fileName, c1, c2, color, thickness)
% doesn't seam to work
fp = fopen(fileName, 'a');

%fprintf(fp, 'usemtl %s\n', color);
fprintf(fp, 'v %d %d %d\n', c1(1), c1(2), c1(3));
fprintf(fp, 'v %d %d %d\n', c2(1), c2(2), c2(3));
fprintf(fp, 'v %d %d %d\n', c1(1)+thickness, c1(2), c1(3));
fprintf(fp, 'v %d %d %d\n', c2(1)+thickness, c2(2), c2(3));

fprintf(fp, 'f -4 -3 -2 -1\n');

fclose(fp);
