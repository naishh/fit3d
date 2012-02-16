function WallsPcPlaneFitter = getWallFromPc(MAP)
figure; hold on;

% get 3d points
XYZ = MAP(:,1:3)';

% fits plane in datapoints and calcs wall normal
%[normalRansac, P, inliers] = ransacfitplane(XYZ, 1, 1, 100, 1000);
%save('ransacVars.mat','normalRansac', 'P', 'inliers');
load('ransacVars.mat')

% plot only inliers
plot3(MAP(inliers(:),1), MAP(inliers(:),2), MAP(inliers(:),3),'k+')

% use only a b c (xyz)
normalRansac = normalRansac(1:3)

% increase normal  makes wall bigger (easyer to see an error)
normalRansacIncr = 10 * normalRansac

% no displacement
WallsPcPlaneFitter  = normalToWall(normalRansacIncr, [0;0;0], 1)
plotBuilding(WallsPcPlaneFitter, 1)
pause;

%  displacement by hand 
% todo check with isaac how this can be computed (using mean of pointcloud?)
% (get with ginput)
% Xmid = -1.0899
% Zmid = 4.5029
% t = [Xmid;0;Zmid]
% WallsPcPlaneFitter = normalToWall(normalRansacIncr, t, 1)
% plotBuilding(WallsPcPlaneFitter ,1)
% pause;

	
% %  displacement by a point from pointcloud
% t = P(:,2)
% WallsPcPlaneFitter = normalToWall(normalRansacIncr, t, 1)
% plotBuilding(WallsPcPlaneFitter ,1)


%% %  TODO displacement by average of pointcloud
%tMean = mean(MAP(inliers(:),1:3))'
%WallsPcPlaneFitter = normalToWall(normalRansacIncr, tMean, 1)
%plotBuilding(WallsPcPlaneFitter ,1)

axis equal
