close all
figure; hold on;

% load map
load MAP; XYZ = MAP(:,1:3)';

% fits plane in datapoints and calcs wall normal
[normalRansac, P, inliers] = ransacfitplane(XYZ, 1, 1, 100, 1000)

% plot only inliers
plot3(MAP(inliers(:),1), MAP(inliers(:),2), MAP(inliers(:),3),'k+')

% use only a b c (xyz)
normalRansac = normalRansac(1:3)

% increas so its easyer to see an error
factor = 10;
normalRansac = normalRansac*factor

% middle of point cloud for displacement
% (get with ginput)
Xmid = -1.0899
Zmid = 4.5029
t = [Xmid;0;Zmid]

% no displacement
wall1 = normalToWall(normalRansac, [0;0;0], 1)
plotBuilding(wall1,1)
pause;

%  displacement
wall2 = normalToWall(normalRansac, t, 1)
plotBuilding(wall2,1)
	

axis equal
