function Dataset = getDataset(DatasetName, startPath)
% set defaults before:
startPathDataset = [startPath,'/dataset/'];
Dataset.name = DatasetName;
Dataset.postfix = '.jpg';
Dataset.EdgeDetectorParam.type = 'canny';
Dataset.HoughParam.ThetaH.stretchAngle	= 30;
Dataset.HoughParam.ThetaV.stretchAngle	= 10;

% customs
if strcmp(DatasetName,'Floriande') == 1
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.baseFile = 'outd';
	Dataset.imNrStart = 8; 
	Dataset.imNrEnd = 8;
	Dataset.EdgeDetectorParam.thresh		= 0.05; 
%	Dataset.EdgeDetectorParam.thresh		= 0.35; 
%imNr = 5435; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); load('XYangleFilter_floriande_5447.mat'); load('XYcropRegionFloriande5435.mat'); edgeDetectorParam.thresh		= 0.55; HoughParam.ThetaH.StretchAngle	= 30;HoughParam.ThetaV.StretchAngle	= 10; fileShort 						= 'floriande5435';
%imNr = 5447; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); 

elseif strcmp(DatasetName, 'Spil') == 1
	Dataset.fileShort 						= 'spil6';
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.path 							= '../dataset/datasetSpil/datasetSpilRect/';
	Dataset.baseFile 						= 'P_rect';
	Dataset.imStartNr 						= 6;
	Dataset.endRange 						= 6; 
	Dataset.colorModel						= 'none'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.15; 
	% TODO make function which generate all colormodels images and attach to dataset
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 45; 
elseif strcmp(DatasetName ,'Aalsmeer') == 1
% imNr = 6680; file = sprintf('../dataset/fullDatasets/aalsmeer/undist__MG_%d.jpg', imNr); load('XYangleFilter_aalsmeer6680.mat');
%fileShort 						= 'aalsmeer6680';

elseif strcmp(DatasetName, 'Antwerpen_6223_crop1') == 1
	Dataset.path = [startPathDataset,'Antwerpen/'];
	Dataset.baseFile						= 'IMG_'
	%Dataset.imStartNr 						= 6220;
	%Dataset.EdgeDetectorParam.thresh		= 0.45; 
	Dataset.imStartNr 						= 6223;
	%Dataset.EdgeDetectorParam.thresh		= 0.2; 
	Dataset.EdgeDetectorParam.thresh		= 0.65; 
	Dataset.postfix 						= '_crop1.JPG';
	Dataset.fileShort						= ['antwerpen_', int2str(Dataset.imStartNr), '_crop1'];
	Dataset.colorModel						= 'HSV_V'; % {'HSV_V','RGB','BW'};
	Dataset.HoughParam.ThetaH.stretchAngle	= 5;
	Dataset.HoughParam.ThetaV.stretchAngle	= 5;
	Dataset.HoughParam.fillGap 				= 20;
	Dataset.HoughParam.minLength 			= 35; 
elseif strcmp(DatasetName, 'Antwerpen_6220') == 1
	Dataset.path = [startPathDataset,'Antwerpen/'];
	Dataset.baseFile						= 'IMG_'
	Dataset.imStartNr 						= 6220;
	Dataset.EdgeDetectorParam.thresh		= 0.45; 
	Dataset.postfix 						= '.JPG';
	Dataset.fileShort						= ['antwerpen_', int2str(Dataset.imStartNr), '_nocrop'];
	Dataset.colorModel						= 'HSV_V'; % {'HSV_V','RGB','BW'};
	Dataset.HoughParam.ThetaH.stretchAngle	= 5;
	Dataset.HoughParam.ThetaV.stretchAngle	= 5;
	Dataset.HoughParam.fillGap 				= 20;
	Dataset.HoughParam.minLength 			= 35; 
else
	error('no matching dataset name');
end

% set defaults after
Dataset.file = [Dataset.path, Dataset.baseFile, int2str(Dataset.imStartNr), Dataset.postfix];

Dataset.HoughParam.ThetaV.Start 		= 0;
Dataset.HoughParam.ThetaV.Start 		= Dataset.HoughParam.ThetaV.Start - Dataset.HoughParam.ThetaV.stretchAngle;
Dataset.HoughParam.ThetaH.Start 		= 0;
Dataset.HoughParam.ThetaH.Start 		= Dataset.HoughParam.ThetaH.Start - Dataset.HoughParam.ThetaH.stretchAngle;
Dataset.HoughParam.ThetaH.End 			= 0;
Dataset.HoughParam.ThetaH.End 			= Dataset.HoughParam.ThetaH.End + Dataset.HoughParam.ThetaH.stretchAngle;
Dataset.HoughParam.ThetaV.End 			= 0;
Dataset.HoughParam.ThetaV.End 			= Dataset.HoughParam.ThetaV.End + Dataset.HoughParam.ThetaV.stretchAngle;
Dataset.HoughParam.ThetaH.Resolution  	= 0.5;
Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
Dataset.HoughParam.thresh 				= 0;
% sets the max nr of lines hough finds:
Dataset.HoughParam.nrPeaks 				= 200;
% the bigger this value the more lines are found
Dataset.HoughParam.projectionScale 		= 1;

