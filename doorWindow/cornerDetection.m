close all;
imNr = 5447; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); fileShort = 'floriande5447'; load('XYcropRegionFloriande5447.mat'); 

% imNr = 6680; file = sprintf('../dataset/fullDatasets/aalsmeer/undist__MG_%d.jpg', imNr); 
% fileShort = 'aalsmeer6680';
% load('XYcropRegionAalsmeer6680.mat');


imRGB = imread(file);
imHSV = rgb2hsv(imRGB);
imBW  = imHSV(:,:,3);
imBW  = cropImage(imBW, X,Y);

CornerParam.method = 'Harris';
CornerParam.method = 'MinimumEigenvalue';
CornerParam.nrCorners = 500;
CornerParam.QualityLevel = 0.15;
CornerParam.SensitivityFactor = 0.24;

if CornerParam.method == 'MinimumEigenvalue'
	C = corner(imBW, CornerParam.method, CornerParam.nrCorners,'QualityLevel',CornerParam.QualityLevel);
else
	C = corner(imBW, CornerParam.method, CornerParam.nrCorners,'QualityLevel',CornerParam.QualityLevel, 'SensitivityFactor',CornerParam.SensitivityFactor);
end

% TODO REMOVE sensitv @ minim eign val method
paramStr = sprintf('src_%s_method_%s_nrCorners_%d_butFound_%d_QualityLevel_%s_SensitivityFactor_%s', fileShort, CornerParam.method, CornerParam.nrCorners, size(C,1), num2str(CornerParam.QualityLevel),num2str(CornerParam.SensitivityFactor))

fgC = figure;imshow(imBW);hold on;
hold on;plot(C(:,1),C(:,2),'r+','MarkerSize',10);

savePath = 'resultsCornerDet/';
saveas(fgC, [savePath,'result_cornerDet__',paramStr],'png');
