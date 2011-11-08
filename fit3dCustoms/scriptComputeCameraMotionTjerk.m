datasetName = 'datasetSpilPostRect'
setup

% This will show the steps to compute the motion of a camera given some
% images (with no radial distortion)


maxFrames = 8;


% tj. make sure some part of the program doesn't use the old calibration matrix
clear KCanon10GOOD;

% Load camera calibration
load([startPathRoot, '/dataset/datasetSpil/Kbram.mat']);

%% GET SIFT FEATURES
% We use VL_FEAT though regular sift can be employed. Make sure to delete
% all _BW.jpg files from the data folder!!!
fprintf('\n\n\nEXTRACTING SIFT FEATURES\n\n\n');

datasetDir
[F,Files] = getSIFTgray(datasetDir, maxFrames,1,'VL_FEAT');

%% COMPUTE MOTION
% Given the SIFT features, we match them accross frames and compute the
% motion with the specifiec algorithm. See help computeCameraMotion for an
% extended explanation.
fprintf('\n\n\nCOMPUTING MOTION\n\n\n');
[Fplus, PcamPlus, PcamX, FplusExtra,KBA] = computeCameraMotion('VL_FEAT',F, 0.4, 1, 2500, Kbram, maxFrames, true, '8pts', 0.001, 500);

disp(['saving vars in dir ',datasetDir] );
mkdir(datasetName);
save([datasetName,'/Allvars.mat']);
save([datasetName,'/Fplus.mat'], 'Fplus');
save([datasetName,'/PcamX.mat'], 'PcamX');
disp('done');


fprintf('\n\n\nThe motion has been computed (and stored in PcamX)!\n See help computeCameraMotion for details on the output.\n\n\n');


