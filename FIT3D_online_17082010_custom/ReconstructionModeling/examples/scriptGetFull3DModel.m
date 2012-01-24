% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

%% SCRIPT TO OBTAIN A FULL 3D MODEL INCLUDING THE RECONSTRUCTED STRUCTURE,
%% THE IMAGES PLOTTED IN SPACE AND AN APPROXIMATION USING PLANNAR PATCHES
    
%% LOAD DATA
% Load camera motion PcamScaled
load(strcat(install_path,'/ReconstructionModeling/examples/data/PcamScaled.mat'));

% Load image features
load(strcat(install_path,'/ReconstructionModeling/examples/data/Fplus.mat'));

% Load image features before ransac (for a denser reconstruction)
load(strcat(install_path,'/ReconstructionModeling/examples/data/FplusExtra.mat'));

% Load camera calibration
load(strcat(install_path,'/ReconstructionModeling/examples/data/K.mat'));

% Load Files structure for reading the images
load(strcat(install_path,'/ReconstructionModeling/examples/data/Files.mat'));

% Fix image location
Files.dir = strcat(install_path,Files.dir);

%% SET PARAMETERS
distanceFromCamera = 30;
plotImagesInSpace = true;
plotPointCloud = true;
fitPlanes = true;
nofPlanes = 200;
planeThreshold = 0.01;
density = 50;
closestNPoints = 500;
minPoints = 20;
ransacIterations = 200;
maxDistance = 10;
startFrame = 1;

%% OBTAIN THE MODEL
fprintf('\n\n\nCALCULATING MODEL...\n\n\n');
MAP = build3dcMap(FplusExtra,PcamScaled,Kcanon10GOOD,Files,distanceFromCamera,plotImagesInSpace,plotPointCloud,fitPlanes,nofPlanes,planeThreshold,density,closestNPoints,minPoints,ransacIterations,maxDistance,startFrame);

fprintf('------------------------------------------\n');
fprintf('INPUT:\n\n');
fprintf('- Camera matrices Pcam\n');
fprintf('- Calibration matrix K\n');
fprintf('- Matching features Fplus\n');
fprintf('- Files struct\n');
fprintf('- Various fine tuning parameters\n');
fprintf('------------------------------------------\n');

fprintf('------------------------------------------\n');
fprintf('OUTPUT:\n\n');
fprintf('- 3D model (matlab format)\n');
fprintf('- 3dc file (3dmap.3dc) with point cloud\n');
fprintf('- 3dc file (3dmapFrames.3dc) with images in 3D space\n');
fprintf('- 3dc file (3dmapPlane.3dc) with found planes with real image projections\n');
fprintf('- 3dc file (3dmapPlaneC.3dc) with coloured planes\n');
fprintf('------------------------------------------\n');

fprintf('\n\n\nMODEL CALCULATED!. A 3D model has been built.');
fprintf('n\nTo see it we recommend using OpenSceneGraph.');
fprintf('\nYou can visualize the model by typing in a terminal window: >osgviewer 3dmapPlane.3dc 3dmap.3dc 3dmapFrames.3dc \n\n');
fprintf('Alternatively, you can see the structure in Matlab by typing:\n\n');
fprintf('plot3(MAP(:,1),MAP(:,2),MAP(:,3),''r.\'')\n\n\n');
