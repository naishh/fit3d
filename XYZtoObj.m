function XYZtoObj(X,Y,Z, nDatapoint)
fp = fopen('t.obj', 'a');

length(X)
fprintf(fp, 'v %d %d %d\n', X(1), Y(1), Z(1));
fprintf(fp, 'v %d %d %d\n', X(2), Y(2), Z(2));
% draws a line parallel to it to fake a line by a small plane
fprintf(fp, 'v %d %d %d\n', X(1)+1000, Y(1), Z(1));
fprintf(fp, 'v %d %d %d\n', X(2)+1000, Y(2), Z(2));
fprintf(fp, 'vt 1 0 0\n');
fprintf(fp, 'vt 1 0 0\n');
fprintf(fp, 'vt 1 0 0\n');
fprintf(fp, 'vt 1 0 0\n');
nDatapoint = nDatapoint/10 *4 -3
fprintf(fp, 'f %d/%d %d/%d %d/%d %d/%d\n', nDatapoint, nDatapoint, nDatapoint+1, nDatapoint+1, nDatapoint+2, nDatapoint+2, nDatapoint+3, nDatapoint+3);

fclose(fp)
