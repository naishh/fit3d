close all
load MAP
XYZ = MAP(:,1:3)';
[B, P, inliers] = ransacfitplane(XYZ, 1, 1, 100, 1000);
B

load('../../../mats/WallsPcMiddle2.mat')
clf;
plotBuilding(WallsPc)
hold on;
pause;
plot3(MAP(:,1), MAP(:,2), MAP(:,3), 'r+')


pause;
% wall normal


% middle of point cloud for displacement

Xmid = -1.0899
Zmid = 4.5029
Origin = [Xmid,0,Zmid]'

factor = 10;
B = B(1:3)
B = B*factor

plotVector3([0;0;0], B)
pause;
%plotVector3(Origin, Origin+B)
%pause;

C = [0.7880         0    0.6156]'
plotVector3([0 0 0]', C);
pause;
plotVector3(Origin, Origin +  C);
axis square
