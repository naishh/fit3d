% TODO regel general properties per dataset, specific properties per imgnr 
function Dataset = getDataset(DatasetName, startPath)
% set defaults before:
startPathDataset = [startPath,'/dataset/'];
Dataset.name = DatasetName;
Dataset.postfix = '.jpg';
Dataset.EdgeDetectorParam.type = 'canny';
Dataset.HoughParam.ThetaH.stretchAngle	= 30;
Dataset.HoughParam.ThetaV.stretchAngle	= 10;
Dataset.HoughParam.ThetaH.Resolution  	= 0.5;
Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
Dataset.HibaapParam.XvThresh			= 0.5;
Dataset.HibaapParam.YhThresh			= 0.5;
Dataset.HibaapParam.incrFactor			= 20;
Dataset.cCornerParam.minVotes			= 2;

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
	Dataset.path 							= '../dataset/Spil/datasetSpilRect/';
	Dataset.baseFile 						= 'P_rect';
	Dataset.imStartNr 						= 6;
	Dataset.endRange 						= 6; 
	Dataset.colorModel						= 'none'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.15; 
	% TODO make function which generate all colormodels images and attach to dataset
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 45; 
elseif strcmp(DatasetName, 'Spil1Trans') == 1
	Dataset.fileShort 						= 'Spil1Trans';
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.path 							= '../dataset/Spil/datasetSpilRect/';
	Dataset.baseFile 						= 'P_rect';
	Dataset.postfix 						= '_transformed.jpg';
	Dataset.imStartNr 						= 6;
	Dataset.endRange 						= 6; 
	Dataset.colorModel						= 'none'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.45; 
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 30; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 3;
	Dataset.HoughParam.ThetaV.stretchAngle	= 10;
elseif strcmp(DatasetName, 'Spil1TransCrop1') == 1
	Dataset.fileShort 						= 'Spil1TransCrop1';
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.path 							= '../dataset/Spil/datasetSpilRect/';
	Dataset.baseFile 						= 'P_rect';
	Dataset.postfix 						= '_transformed_crop1.jpg';
	Dataset.imStartNr 						= 6;
	Dataset.endRange 						= 6; 
	Dataset.colorModel						= 'none'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.45; 
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 30; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 3;
	Dataset.HoughParam.ThetaV.stretchAngle	= 10;
	Dataset.HibaapParam.incrFactor			= 10;
elseif strcmp(DatasetName, 'Spil1TransCrop2') == 1
	Dataset.fileShort 						= 'Spil1TransCrop2';
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.path 							= '../dataset/Spil/datasetSpilRect/';
	Dataset.baseFile 						= 'P_rect';
	Dataset.postfix 						= '_transformed_crop2.jpg';
	Dataset.imStartNr 						= 6;
	Dataset.colorModel						= 'none'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.25; 
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 30; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 3;
	Dataset.HoughParam.ThetaV.stretchAngle	= 10;
	Dataset.HibaapParam.incrFactor			= 75;
elseif strcmp(DatasetName, 'Ort1') == 1
	Dataset.fileShort 						= 'Ort1';
	Dataset.path 							= '../dataset/Spil/datasetOrt/';
	Dataset.baseFile 						= 'IMAG';
	Dataset.postfix 						= '.jpg';
	Dataset.imStartNr 						= 1994;
	Dataset.colorModel						= 'BW'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.20; 
	Dataset.HoughParam.fillGap 				= 15;
	Dataset.HoughParam.minLength 			= 120; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 5;
	Dataset.HoughParam.ThetaV.stretchAngle	= 5;
elseif strcmp(DatasetName, 'OrtCrop1') == 1
	Dataset.fileShort 						= 'OrtCrop1';
	Dataset.path 							= '../dataset/Spil/datasetOrt/';
	Dataset.baseFile 						= 'IMAG';
	Dataset.postfix 						= '_crop1.jpg';
	Dataset.imStartNr 						= 1994;
	Dataset.colorModel						= 'BW'; % {'HSV_V','RGB','BW'};
	%Dataset.EdgeDetectorParam.thresh		= 0.20; 
	Dataset.EdgeDetectorParam.thresh		= 0.25; 
	Dataset.HoughParam.fillGap 				= 15;
	Dataset.HoughParam.minLength 			= 120; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 5;
	Dataset.HoughParam.ThetaV.stretchAngle	= 5;
	Dataset.HibaapParam.XvThresh			= 0.3;
	Dataset.HibaapParam.YhThresh			= 0.3;
	Dataset.HibaapParam.incrFactor			= 75;

	Dataset.cCornerParam.minVotes			= 1;

elseif strcmp(DatasetName, 'SpilPost18Trans') == 1
	Dataset.fileShort 						= 'SpilPost18Trans';
	Dataset.path 							= '../dataset/Spil/datasetSpilPostRect/';
	Dataset.baseFile 						= 'P_rect';
	Dataset.postfix 						= '_transformed.png';
	Dataset.imStartNr 						= 1120918;
	Dataset.colorModel						= 'ORIGINAL'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.40; 
	Dataset.HoughParam.fillGap 				= 15;
	Dataset.HoughParam.minLength 			= 30; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 5;
	Dataset.HoughParam.ThetaV.stretchAngle	= 5;
	Dataset.HibaapParam.XvThresh			= 0.4;
	Dataset.HibaapParam.YhThresh			= 0.8;
	Dataset.HibaapParam.incrFactor			= 25;

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
Dataset.HoughParam.thresh 				= 0;
% sets the max nr of lines hough finds:
Dataset.HoughParam.nrPeaks 				= 200;
% the bigger this value the more lines are found
Dataset.HoughParam.projectionScale 		= 1;

