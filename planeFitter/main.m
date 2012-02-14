load MAP
XYZ = MAP(:,1:3)';
[B, P, inliers] = ransacfitplane(XYZ, 1, 1, 100, 1000);
B

load('../mats/WallsPcMiddle2.mat')
clf;
plotBuilding(WallsPc)
hold on;
pause;
plot3(MAP(:,1), MAP(:,2), MAP(:,3), 'r+')
