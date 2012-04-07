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
modules = {'ImReader','HoughResult', 'Hibaap', 'ClassRect'}
%Dataset = getDataset('SpilFrontal6345',startPath, modules)
Dataset = getDataset('Spil1TransImproved',startPath, modules)
%Dataset = getDataset('Ort1Crop1',startPath, modules)



