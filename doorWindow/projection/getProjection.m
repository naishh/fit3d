function Projection = getProjection(Dataset)
load([Dataset.path, 'mats/K.mat']);
Projection.K = K
load([Dataset.path, 'mats/MAP.mat']);

% get wall from point cloud
WallsPc = getWallFromPc(MAP);
Projection.wallNormal = getNormalFromWall(WallsPc, 1, 0);
Projection.MAP = MAP;
Projection.WallsPc = WallsPc
