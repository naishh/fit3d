% TODO fix scaleup for scales =! 1
function cornerScaleAccu = getCorners(plotme)
% TODO make dateset config

imNr = 5435; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); load('XYcropRegionFloriande5435.mat'); scaleRange = (1/4):-(1/16):(1/16);

%imNr = 5447; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); fileShort = 'floriande5447'; load('XYcropRegionFloriande5447.mat'); 
%imNR = 6; file = sprintf('../dataset/datasetSpil/datasetSpilRect/P_rect6.jpg'); fileShort = 'spil6'; load('XYcropRegionSpil6.mat');

%imNr = 6680; file = sprintf('../dataset/fullDatasets/aalsmeer/undist__MG_%d.jpg', imNr); 
%fileShort = 'aalsmeer6680';
%load('XYcropRegionAalsmeer6680.mat');

CornerParam.blurFactor = 5;

im = imread(file);
% if image is black and white
if size(im,3) == 1
	imBW = im2double(im);
else
	imHSV = rgb2hsv(im);
	imBW  = imHSV(:,:,3);
end
imBW     = cropImage(imBW, X,Y);

imBWori  = imBW;


CornerParam.savePath = 'resultsCornerDet/';
CornerParam.method = 'Harris';
%CornerParam.method = 'MinimumEigenvalue';
CornerParam.nrCorners = 800;
CornerParam.QualityLevel = 0.3;
CornerParam.SensitivityFactor = 0.04;

i=0;
%scaleRange = (1/4):-(1/16):(1/16);
scaleRange = [1/4];
for scale=scaleRange;
	Corners = corner(imBW, CornerParam.method, CornerParam.nrCorners,'QualityLevel', CornerParam.QualityLevel);
	CM = cornermetric(imBW);
	CMadj = imadjust(CM);
	if plotme
		%figure;imshow(CMadj);
		%fgC = figure;
		imshow(imBW); hold on;
		plot(Corners(:,1),Corners(:,2),'r+','MarkerSize',10);
	end
	%paramStr = sprintf('src_%s_method_%s_nrCorners_%d_butFound_%d_scale_%s', fileShort, CornerParam.method, CornerParam.nrCorners, size(C,1), num2str(scale));
	%saveas(fgC, [CornerParam.savePath,'result_cornerDet__',paramStr],'png');
	imBW = imresize(imBWori, scale, 'bicubic');
	i=i+1
	cornerScaleAccu(i).Corners = Corners;
	cornerScaleAccu(i).scale = scale;
	cornerScaleAccu(i).cornerMetricIm = CMadj;
end
