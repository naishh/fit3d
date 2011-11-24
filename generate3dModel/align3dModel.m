close all;

%load ReconstructionModelingOutputvars
load MAP;

% plot small dots and project on ground plane by leaving Y value 0
plot(MAP(:,1),MAP(:,3),'r.','MarkerSize',1);
hold on

% do ginput at matlab console and manually fill X and Z here:
X = [-8.6977, -1.7310, 0.0312, -0.7704, 4.9011];
Z = [11.9792, 7.2957, 9.9875, 11.5275, 19.991];

% extend coord
X(5) =  X(4)+((X(5)-X(4))*3)
Z(5) =  Z(4)+((Z(5)-Z(4))*3)

% plots cornerpoint in pointcloud
plot(X,Z,'k+-','MarkerSize',10);

% %yGround = 1;
yGround = 1;
% %yAir = -3;	
yAir = -3.2;	
%yAir = -4;	
bConnectLastToFirstWall = false;
WallsPc = generateWallsFromCornerPoints(X,Z, yGround,yAir, bConnectLastToFirstWall);
save('../mats/WallsPc.mat','WallsPc');

