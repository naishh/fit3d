close all;

%load ReconstructionModelingOutputvars
load MAP;

% plot small dots and project on ground plane by leaving Y value 0
%plot(MAP(:,1),MAP(:,3),'r.','MarkerSize',1);
%hold on

X = [-8.6977, -1.7310, 0.0312, -0.7704, 4.9011];
Z = [11.9792, 7.2957, 9.9875, 11.5275, 19.991];
% plots cornerpoint in pointcloud
%plot(X,Y,'k+-','MarkerSize',10);

yGround = 1;
yAir = -3.5;	
WallsPc = generateWallsFromCornerPoints(X,Z, yGround,yAir);
save('../mats/WallsPc.mat','WallsPc');

