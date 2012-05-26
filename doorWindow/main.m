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

%modules = {'ImReader','HoughResult', 'Hibaap', 'ClassRectII'}
modules = {'ImReader','HoughResult', 'Hibaap', 'ClassRectI'}
%Dataset = getDataset('SpilFrontal6345',startPath, modules)
Dataset = getDataset('Dirk4Trans',startPath, modules)
%Dataset = getDataset('Ort1Crop1',startPath, modules)



