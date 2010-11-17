function cubeToObj(file, lastF, center, r)
% todo lastF inbouwen
%fp = fopen(file, 'w');
fp = fopen(file, 'w');

c1 = [center-r center+r center-r];
c2 = [center+r center+r center-r];
c3 = [center-r center-r center-r];
c4 = [center-r center-r center-r];
c5 = [center-r center+r center+r];
c6 = [center+r center+r center+r];
c7 = [center+r center-r center+r];
c8 = [center-r center-r center+r];

% define vertices
fprintf(fp, 'v %d %d %d\n', c1(1), c1(2), c1(3));
fprintf(fp, 'v %d %d %d\n', c2(1), c2(2), c2(3));
fprintf(fp, 'v %d %d %d\n', c3(1), c3(2), c3(3));
fprintf(fp, 'v %d %d %d\n', c4(1), c4(2), c4(3));
fprintf(fp, 'v %d %d %d\n', c5(1), c5(2), c5(3));
fprintf(fp, 'v %d %d %d\n', c6(1), c6(2), c6(3));
fprintf(fp, 'v %d %d %d\n', c7(1), c7(2), c7(3));
fprintf(fp, 'v %d %d %d\n', c8(1), c8(2), c8(3));
% draw planes
fprintf(fp, 'f %d %d %d %d\n',1, 2, 3, 4);
fprintf(fp, 'f %d %d %d %d\n',5, 6, 7, 8);
fprintf(fp, 'f %d %d %d %d\n',1, 5, 4, 8);
fprintf(fp, 'f %d %d %d %d\n',2, 3, 6, 7);
fprintf(fp, 'f %d %d %d %d\n',1, 5, 6, 2);
fprintf(fp, 'f %d %d %d %d\n',4, 3, 7, 8);

fclose(fp);
