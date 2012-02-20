clear;
% run setup first
close all;
cd ..;setup;cd doorWindow

%Dataset = getDataset('Spil4BigOutline',startPath)
%Dataset = getDataset('Floriande0',startPath)
%Dataset = getDataset('Floriande0Outline',startPath)
%Dataset = getDataset('SpilZonnetje70',startPath)

modules = {'ImReader','HoughResult', 'Hibaap', 'ClassRect'}
%getDataset('Spil1Trans',startPath, modules)
%getDataset('Spil1TransCrop1',startPath, modules)
%getDataset('Suma7Crop1',startPath, modules)

getDataset('OrtCrop1',startPath, modules)
