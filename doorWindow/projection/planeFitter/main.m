close all
figure; hold on;

% load map
load('MAPspil4small.mat'); XYZ = MAP(:,1:3)';

% fits plane in datapoints and calcs wall normal
[normalRansac, P, inliers] = ransacfitplane(XYZ, 1, 1, 100, 1000)
normalRansac

% plot only inliers
plot3(MAP(inliers(:),1), MAP(inliers(:),2), MAP(inliers(:),3),'k+')


% % plot an inlier
% plot3(P(1,2), P(2,2), P(3,2),'r+');
% pause;


% use only a b c (xyz)
normalRansac = normalRansac(1:3)

% increas so its easyer to see an error
factor = 10;
normalRansac = normalRansac*factor


% % no displacement
% WallsPcPlaneFitter  = normalToWall(normalRansac, [0;0;0], 1)
% plotBuilding(WallsPcPlaneFitter, 1)
% pause;

% %  displacement by hand 
% % todo check with isaac how this can be computed (using mean of pointcloud?)
% % (get with ginput)
% Xmid = -1.0899
% Zmid = 4.5029
% t = [Xmid;0;Zmid]
% WallsPcPlaneFitter = normalToWall(normalRansac, t, 1)
% plotBuilding(WallsPcPlaneFitter ,1)
% pause;


	
% %  displacement by a point from pointcloud
% t = P(:,2)
% WallsPcPlaneFitter = normalToWall(normalRansac, t, 1)
% plotBuilding(WallsPcPlaneFitter ,1)


%  TODO displacement by average of pointcloud
mean(MAP(inliers(:),1:3))
err
t = P(:,2)
WallsPcPlaneFitter = normalToWall(normalRansac, t, 1)
plotBuilding(WallsPcPlaneFitter ,1)

save('WallsPcPlaneFitter.mat','WallsPcPlaneFitter')

axis equal
