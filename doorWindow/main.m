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

%modules = {'ImReader','HoughResult', 'Hibaap', 'ClassRect'}
modules = {'ImReader','HoughResult', 'Hibaap'}
%getDataset('Spil1Trans',startPath, modules)
%Dataset = getDataset('SpilFrontal6345',startPath, modules)
Dataset = getDataset('Spil1TransImproved',startPath, modules)

%getDataset('OrtCrop1',startPath, modules)


