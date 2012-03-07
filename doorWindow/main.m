clear;
% run setup first
close all;
cd ..;setup;cd doorWindow

%Dataset = getDataset('Spil4BigOutline',startPath)
%Dataset = getDataset('Floriande0',startPath)
%Dataset = getDataset('Floriande0Outline',startPath)
%Dataset = getDataset('SpilZonnetje70',startPath)

showImEdge = 1;
showImHough = 1;

modules = {'ImReader','HoughResult', 'Hibaap', 'ClassRect'}
%getDataset('Spil1Trans',startPath, modules)
Dataset = getDataset('SpilFrontal6345',startPath, modules)

%getDataset('OrtCrop1',startPath, modules)


