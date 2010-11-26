function XYZtoObj(fileName, X,Y,Z, nDatapoint)
fp = fopen(fileName, 'a');

fprintf(fp, 'v %d %d %d\n', X(1), Y(1), Z(1));
fprintf(fp, 'v %d %d %d\n', X(2), Y(2), Z(2));
fprintf(fp, 'l %d %d\n', nDatapoint, nDatapoint+1);

fclose(fp)
