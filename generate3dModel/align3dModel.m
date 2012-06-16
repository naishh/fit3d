close all;

startPath = pwd();
path(path,startPath);
path(path,[startPath, '/exportFig']);


% %load ReconstructionModelingOutputvars
% datasetName = 'SpilRect'
% datasetDir = [startPath, '/dataset/Spil/',datasetName,'/'];
% load([datasetDir,'MAP_',datasetName,'.mat']);
load MAP

figure;
plot3(MAP(:,1),MAP(:,2),MAP(:,3),'k.','MarkerSize',1);
pause;


X = MAP(:,1);
Xv = abs(X-mean(X));
[Sorted, XvIdx]= sort(Xv);
XvIdxCrop = XvIdx(1:round(0.95*length(Xv)));
%1:round(length(Xv)/100)
Idx = XvIdxCrop; figure; plot3(MAP(Idx,1),MAP(Idx,2),MAP(Idx,3),'k.','MarkerSize',3); axis equal
pause;



%Z = MAP(XvIdxCrop,3);
Z = MAP(:,3);
Zv = abs(Z-mean(Z));
[Sorted, ZvIdx]= sort(Zv);
ZvIdxCrop = ZvIdx(1:round(0.99*length(Zv)));
Idx = ZvIdxCrop; figure; plot(MAP(Idx,1),MAP(Idx,3),'k.','MarkerSize',1); axis equal
pause;






% plot small dots and project on ground plane by leaving Y value 0
figure;
plot(MAP(:,1),MAP(:,3),'r.','MarkerSize',1);
hold on

%Z = Z+10

%[X,Z] = ginput(2); 
%save(['XZ',datasetName],'X','Z');

%% do ginput at matlab console and manually fill X and Z here:
X = [-8.6977, -1.7310, 0.0312, -0.7704, 4.9011];
Z = [11.9792, 7.2957, 9.9875, 11.5275, 19.991];
%
%% extend coord
X(5) =  X(4)+((X(5)-X(4))*3)
Z(5) =  Z(4)+((Z(5)-Z(4))*3)



% plots cornerpoint in pointcloud
plot(X,Z,'k+-','MarkerSize',10);

% %yGround = 1;
% %yAir = -3;	
%yAir = -4;	

%yGround = 1;
%yAir = -3.2;	

yGround = 0
yAir = -3 

bConnectLastToFirstWall = false;

WallsPc = generateWallsFromCornerPoints(X,Z, yGround,yAir, bConnectLastToFirstWall);
load('../mats/WallsPcMiddle2.mat')
%save('../mats/WallsPcMiddleParaFar.mat','WallsPc');


