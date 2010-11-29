function XYZtoObj(fileName, c1, c2, color)
%function XYZtoObj(fileName, X,Y,Z, nDatapoint)
fp = fopen(fileName, 'a');

fprintf(fp, 'usemtl %s\n', color);
fprintf(fp, 'v %d %d %d\n', c1(1), c1(2), c1(3));
fprintf(fp, 'v %d %d %d\n', c2(1), c2(2), c2(3));
%fprintf(fp, 'l %d %d\n', nDatapoint, nDatapoint+1);
fprintf(fp, 'l -2 -1\n');
fprintf(fp, 'usemtl black\n', color);

fclose(fp);
