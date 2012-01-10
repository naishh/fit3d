function Dataset = getDataset(DatasetName)
% set defaults before:
Dataset.name = DatasetName;
Dataset.postfix = '.jpg';
Dataset.EdgeDetectorParam.type = 'canny';
Dataset.HoughParam.ThetaH.stretchAngle	= 30;
Dataset.HoughParam.ThetaV.stretchAngle	= 10;

% customs
if strcmp(DatasetName,'Floriande') == 1
	Dataset.path = [startPath,'/dataset/FloriandeSet1/small/'];
	Dataset.baseFile = 'outd';
	Dataset.imNrStart = 8; 
	Dataset.imNrEnd = 8;
	Dataset.thresh = 0.05;
%	Dataset.EdgeDetectorParam.thresh		= 0.35; 
%imNr = 5435; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); load('XYangleFilter_floriande_5447.mat'); load('XYcropRegionFloriande5435.mat'); edgeDetectorParam.thresh		= 0.55; HoughParam.ThetaH.StretchAngle	= 30;HoughParam.ThetaV.StretchAngle	= 10; fileShort 						= 'floriande5435';
%imNr = 5447; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); 

elseif strcmp(DatasetName, 'Spil') == 1
	Dataset.fileShort 						= 'spil6'
	Dataset.path 							= '../dataset/datasetSpil/datasetSpilRect/';
	Dataset.baseFile 						= 'P_rect';
	Dataset.imStartNr 						= 6;
	Dataset.endRange 						= 6; 
	Dataset.thresh 							= 0.7;
	Dataset.EdgeDetectorParam.thresh		= 0.15; 
	Dataset.colorModel						= 'none'; % {'HSV_V','RGB','BW'};
	% TODO make function which generate all colormodels images and attach to dataset
elseif strcmp(DasateName ,'Aalsmeer') == 1
% imNr = 6680; file = sprintf('../dataset/fullDatasets/aalsmeer/undist__MG_%d.jpg', imNr); load('XYangleFilter_aalsmeer6680.mat');
%fileShort 						= 'aalsmeer6680';

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
Dataset.HoughParam.fillGap 				= 10;
Dataset.HoughParam.minLength 			= 45; 
