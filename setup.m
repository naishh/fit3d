startPath = pwd();
path(path,startPath);
%path(path,[startPath, '/fit3d_includes']);
path(path,[startPath, '/mats']);
path(path,[startPath, '/projections']);
%path(path,[startPath, '/houghlines']);
path(path,[startPath, '/plot']);
%path(path,[startPath, '/houghlines']);
%path(path,[startPath, '/houghlines3d']);
path(path,[startPath, '/project2Normal']);
%path(path,[startPath, '/misc']);
%path(path,[startPath, '/cameraCalibration/toolbox_calib']);
%path(path,[startPath, '/project2d']);
path(path,[startPath, '/doorWindow']);
path(path,[startPath, '/doorWindow/aux']);
path(path,[startPath, '/doorWindow/cCorner_and_Harris']);
path(path,[startPath, '/doorWindow/3rdParty']);
path(path,[startPath, '/aux']);
path(path,[startPath, '/doorWindow/mats']);
disp('added paths succesfully, good luck dude!')
%load outputVars_scriptComputeCameraMotion
