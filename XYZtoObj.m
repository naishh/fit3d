function XYZtoObj(X,Y,Z)
fp = fopen('t.obj', 'a')

% length(X) = 2
length(X)
for i=1:length(X)
	fprintf(fp, 'v %d %d %d\n', X(i), Y(i), Z(i))
	fprintf(fp, 'v %d %d %d\n', X(i)+1, Y(i), Z(i))
	fprintf(fp, 'vt 1 0 0\n');
	fprintf(fp, 'vt 1 0 0\n');
	fprintf(fp, 'f 1/1 2/2 3/3 4/4\n');
end

fclose(fp)
