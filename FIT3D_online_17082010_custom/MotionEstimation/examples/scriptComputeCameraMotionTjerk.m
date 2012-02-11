% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

%% SAMPLE SCRIPT TO COMPUTE THE MOTION OF A CAMERA
% This will show the steps to compute the motion of a camera given some
% images (with no radial distortion)



startPath = '/media/Storage/scriptie/fit3d'
%datasetName = 'datasetSpilRect';
datasetName = 'SpilRect';

datasetDir = [startPath, '/dataset/Spil/',datasetName,'/'];
err
nrFrames = 8;

% Load camera calibration
load([datasetDir,'Kbram.mat']);

%% GET SIFT FEATURES
% We use VL_FEAT though regular sift can be employed. Make sure to delete
% all _BW.jpg files from the data folder!!!
fprintf('\n\n\nEXTRACTING SIFT FEATURES\n\n\n');
%[F,Files] = getSIFTtjerk([datasetDir,'fit3dInput/'],nrFrames,1,'VL_FEAT');
[F,Files] = getSIFT([datasetDir,'fit3dInput/'],nrFrames,1,'VL_FEAT');

%% COMPUTE MOTION
% Given the SIFT features, we match them accross frames and compute the
% motion with the specifiec algorithm. See help computeCameraMotion for an
% extended explanation.
fprintf('\n\n\nCOMPUTING MOTION\n\n\n');
%[Fplus, PcamPlus, PcamX, FplusExtra,KBA] = computeCameraMotion('VL_FEAT',F, 0.4, 1, 2500, Kbram, 8, true, '8pts', 0.001, 500);
[Fplus, PcamPlus, PcamX, FplusExtra,KBA] = computeCameraMotion('VL_FEAT',F, 0.4, 1, 2500, Kbram, 8, true, '8pts', 0.001, 500);

save([datasetDir,'PcamX_',datasetName,'.mat'],'PcamX');
save([datasetDir,'Fplus_',datasetName,'.mat'],'Fplus');
save([datasetDir,'F_',datasetName,'.mat'],'Fplus');

fprintf('\n\n\nThe motion has been computed (and saved)')


