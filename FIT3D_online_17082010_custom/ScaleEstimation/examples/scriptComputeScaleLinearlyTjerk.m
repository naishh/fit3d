% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

%% SCRIPT TO COMPUTE THE SCALE USING A LINEAR METHOD 
% Given a frame-to-frame motion estimation in a sequence of images, the
% scale is computed between each pair of frames considering the first
% motion of length one.


% overload dataset dir from workspace
%datasetName = 'datasetSpilRect';
%startPath = '/mnt/laruina/documents/studie/scriptie/fit3d'
%startPath = '/media/Storage/scriptie/fit3d'
%datasetDir = [startPath, '/dataset/Spil/',datasetName,'/'];

%% LOAD DATA
% Load camera motion PcamX
load([datasetDir,'PcamX_',datasetName,'.mat'])
% Load image features
load([datasetDir,'Fplus_',datasetName,'.mat'])

% Load camera calibration
load([datasetDir,'Kbram.mat']);

%% COMPUTE THE SCALE
fprintf('\n\n\nCOMPUTING SCALE\n\n\n');
[PcamScaled,pts,scales] = adjustScaleWith3Frames(Fplus,PcamX,Kbram,10,'reprojection', 1);

%% TRIANGULATE FEATURES AND BUILD 3D MODEL (3dc format)
MAP = build3dcMap(Fplus,PcamScaled,Kbram,1,30,false,true,false,300,0.1,100,500,50,50,5,1);

% This will write the file 3dmap.3dc containing the reconstructed
% structure. For comparison, the 3D structure without scaling the motion
% can be reconstructed using:
fprintf('\n\n\nBUILD 3D MAP\n\n\n');
%MAP = build3dcMap(Fplus,PcamX,Kbram,1,30,false,true,false,300,0.1,100,500,50,50,5,1);

%% FOR MORE ON 3D RECONSTRUCTION, SEE THE CHAPTER ON RECONSTRUCTION AND
%% MODELING
fprintf('------------------------------------------\n');
fprintf('OUTPUT:\n\n');
fprintf('- 3D model (matlab format)\n');
fprintf('- 3dc file (3dmap.3dc) with point cloud\n');
fprintf('------------------------------------------\n');
fprintf('\n\n\nSCALE CALCULATED!. A 3D model has been built.');

