function cubeToObj(file, lastF, center, r)
% todo lastF inbouwen
%fp = fopen(file, 'a');
fp = fopen(file, 'a');

c1 = [center(1)-r center(2)+r center(3)-r];
c2 = [center(1)+r center(2)+r center(3)-r];
c3 = [center(1)+r center(2)-r center(3)-r];
c4 = [center(1)-r center(2)-r center(3)-r];
c5 = [center(1)-r center(2)+r center(3)+r];
c6 = [center(1)+r center(2)+r center(3)+r];
c7 = [center(1)+r center(2)-r center(3)+r];
c8 = [center(1)-r center(2)-r center(3)+r];

% define vertices
fprintf(fp, 'v %d %d %d\n', c1(1), c1(2), c1(3));
fprintf(fp, 'v %d %d %d\n', c2(1), c2(2), c2(3));
fprintf(fp, 'v %d %d %d\n', c3(1), c3(2), c3(3));
fprintf(fp, 'v %d %d %d\n', c4(1), c4(2), c4(3));
fprintf(fp, 'v %d %d %d\n', c5(1), c5(2), c5(3));
fprintf(fp, 'v %d %d %d\n', c6(1), c6(2), c6(3));
fprintf(fp, 'v %d %d %d\n', c7(1), c7(2), c7(3));
fprintf(fp, 'v %d %d %d\n', c8(1), c8(2), c8(3));
%% draw planes
%fprintf(fp, 'f %d %d %d %d\n',1, 2, 3, 4);
%fprintf(fp, 'f %d %d %d %d\n',5, 6, 7, 8);
%fprintf(fp, 'f %d %d %d %d\n',1, 5, 8, 4);
%fprintf(fp, 'f %d %d %d %d\n',2, 6, 7, 3);
%fprintf(fp, 'f %d %d %d %d\n',1, 5, 6, 2);
%fprintf(fp, 'f %d %d %d %d\n',8, 7, 3, 4);

fprintf(fp, 'f %d %d %d %d\n',-1, -2, -3, -4);
fprintf(fp, 'f %d %d %d %d\n',-5, -6, -7, -8);
fprintf(fp, 'f %d %d %d %d\n',-1, -5, -8, -4);
fprintf(fp, 'f %d %d %d %d\n',-2, -6, -7, -3);
fprintf(fp, 'f %d %d %d %d\n',-1, -5, -6, -2);
fprintf(fp, 'f %d %d %d %d\n',-8, -7, -3, -4);

fclose(fp);
