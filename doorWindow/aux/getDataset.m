% TODO regel general properties per dataset, specific properties per imgnr 
%Dataset = getDataset('Suma7Crop1',startPath)
function Dataset = getDataset(DatasetName, startPath, modules)

% set defaults before:
startPathDataset = [startPath,'/dataset/'];
savePathEps = [startPath,'/doorWindow/resultsEps/'];
Dataset.name = DatasetName;
Dataset.postfix = '.jpg';
Dataset.EdgeDetectorParam.type = 'canny';
Dataset.EdgeDetectorParam.edgeTest 		= false;
Dataset.EdgeDetectorParam.thresh 		= 0.45;
Dataset.HoughParam.ThetaH.stretchAngle	= 30;
Dataset.HoughParam.ThetaV.stretchAngle	= 10;
Dataset.HoughParam.ThetaH.Resolution  	= 0.5;
Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
Dataset.HoughParam.fillGap 				= 10;
Dataset.HoughParam.minLength 			= 45; 
Dataset.HibaapParam.XvThresh			= 0.5;
Dataset.HibaapParam.YhThresh			= 0.5;
Dataset.HibaapParam.incrFactor			= 20;
Dataset.cCornerParam.minVotes			= 2;

% customs
if strcmp(DatasetName,'Floriande0') == 1
	Dataset.fileShort 						= 'Floriande0';
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.baseFile = 'outd';
	Dataset.imStartNr = 0; 
	Dataset.EdgeDetectorParam.thresh		= 0.45; 
	Dataset.colorModel						= 'BW'; % {'HSV_V','RGB','BW', 'ORIGINAL'	};
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 45; 
%	Dataset.EdgeDetectorParam.thresh		= 0.35; 
%imNr = 5435; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); load('XYangleFilter_floriande_5447.mat'); load('XYcropRegionFloriande5435.mat'); edgeDetectorParam.thresh		= 0.55; HoughParam.ThetaH.StretchAngle	= 30;HoughParam.ThetaV.StretchAngle	= 10; fileShort 						= 'floriande5435';
%imNr = 5447; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); 
	Dataset.EdgeDetectorParam.edgeTest 		= false;

elseif strcmp(DatasetName,'Floriande3flip') == 1
	Dataset.fileShort 						= 'Floriande3flip';
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.baseFile = 'flipoutd';
	Dataset.imStartNr = 3; 
	Dataset.EdgeDetectorParam.thresh		= 0.40; 
	Dataset.colorModel						= 'BW'; 
	%Dataset.HoughParam.fillGap 				= 15;
	Dataset.HoughParam.fillGap 				= 15;
	Dataset.HoughParam.minLength 			= 35; 
elseif strcmp(DatasetName,'Floriande0Outline') == 1
	Dataset.fileShort 						= 'Floriande0Outline';
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.baseFile = 'outd';
	Dataset.imStartNr = 0; 
	Dataset.EdgeDetectorParam.thresh		= 0.05; 
	Dataset.colorModel						= 'BW'; % {'HSV_V','RGB','BW', 'ORIGINAL'	};
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 45; 
	Dataset.postfix = 'Outline.jpg';

elseif strcmp(DatasetName, 'Spil4BigOutline') == 1
	Dataset.fileShort 						= 'Spil4BigOutline';
	Dataset.path 							= [startPathDataset,'Spil/SpilRect/'];
	Dataset.baseFile 						= 'P_rect1120558_buildingOutline.png';
	Dataset.postfix 						= '';
	Dataset.colorModel						= 'ORIGINAL'; 
	Dataset.EdgeDetectorParam.thresh		= 0.15; 
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 45; 
elseif strcmp(DatasetName, 'Spil1Trans') == 1
	Dataset.fileShort 						= 'Spil1Trans';
	Dataset.path 							= [startPathDataset,'Spil/SpilRect/'];
	Dataset.baseFile 						= 'P_rect';
	Dataset.postfix 						= '_transformed.jpg';
	Dataset.imStartNr 						= 6;
	Dataset.endRange 						= 6; 
	Dataset.colorModel						= 'none'; 
	Dataset.EdgeDetectorParam.thresh		= 0.45; 
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 30; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 3;
	Dataset.HoughParam.ThetaV.stretchAngle	= 10;
	Dataset.HibaapParam.XvThresh			= 0.7;
	Dataset.HibaapParam.YhThresh			= 2;
elseif strcmp(DatasetName, 'Spil1TransCrop1') == 1
	Dataset.fileShort 						= 'Spil1TransCrop1';
	Dataset.path 							= [startPathDataset,'Spil/SpilRect/'];
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
elseif strcmp(DatasetName, 'Spil1TransImproved') == 1
	Dataset.fileShort 						= 'Spil1TransImproved';
	Dataset.path 							= [startPathDataset,'Spil/SpilRect/'];
	Dataset.baseFile 						= 'P_rect';
	Dataset.postfix 						= '_transformed_improved.jpg';
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
elseif strcmp(DatasetName, 'Spil6') == 1
	Dataset.fileShort 						= 'Spil6';
	Dataset.path 							= [startPathDataset,'Spil/SpilRect/'];
	Dataset.baseFile 						= 'P_rect';
	Dataset.postfix 						= '.jpg';
	Dataset.imStartNr 						= 6;
	Dataset.colorModel						= 'none'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.15; 
	%Dataset.HoughParam.fillGap 				= 10;
	%Dataset.HoughParam.minLength 			= 30; 
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 30; 
	Dataset.HoughParam.ThetaH.Resolution  	= 1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
elseif strcmp(DatasetName, 'Spil1TransCrop2') == 1
	Dataset.fileShort 						= 'Spil1TransCrop2';
	Dataset.path = [startPathDataset,'FloriandeSet1/small/'];
	Dataset.path 							= [startPathDataset,'Spil/SpilRect/'];
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
	Dataset.path 							= [startPathDataset,'Ort/'];
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
elseif strcmp(DatasetName, 'Ort1Crop1') == 1
	Dataset.fileShort 						= 'OrtCrop1';
	Dataset.path 							= [startPathDataset,'Ort/'];
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
elseif strcmp(DatasetName, 'Suma7') == 1
	Dataset.fileShort 						= 'Suma7';
	Dataset.path 							= [startPathDataset,'Suma/'];
	Dataset.baseFile 						= 'IMAG';
	Dataset.postfix 						= '.jpg';
	Dataset.imStartNr 						= 1997;
	Dataset.colorModel						= 'BW'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.35; 
	Dataset.HoughParam.fillGap 				= 15;
	Dataset.HoughParam.minLength 			= 30; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 5;
	Dataset.HoughParam.ThetaV.stretchAngle	= 5;
	Dataset.HibaapParam.XvThresh			= 0.4;
	Dataset.HibaapParam.YhThresh			= 0.8;
	Dataset.HibaapParam.incrFactor			= 25;
elseif strcmp(DatasetName, 'Suma7Crop1') == 1
	Dataset.fileShort 						= 'Suma7Crop1';
	Dataset.path 							= [startPathDataset,'Suma/'];
	Dataset.baseFile 						= 'IMAG';
	Dataset.postfix 						= '_crop1.jpg';
	Dataset.imStartNr 						= 1997;
	Dataset.colorModel						= 'BW'; % {'HSV_V','RGB','BW'};
	Dataset.EdgeDetectorParam.thresh		= 0.35; 
	Dataset.HoughParam.fillGap 				= 15;
	Dataset.HoughParam.minLength 			= 50; 
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 5;
	Dataset.HoughParam.ThetaV.stretchAngle	= 5;
	Dataset.HibaapParam.XvThresh			= 0.4;
	Dataset.HibaapParam.YhThresh			= 0.8;
	Dataset.HibaapParam.incrFactor			= 25;
elseif strcmp(DatasetName, 'SpilZonnetje70') == 1
	Dataset.fileShort 						= 'SpilZonnetje70';
	Dataset.path 							= [startPathDataset,'Spil/SpilZonnetje/'];
	Dataset.baseFile 						= 'IMG_6370'
	Dataset.colorModel						= 'BW'; % {'HSV_V','RGB','BW', 'ORIGINAL'	};
	Dataset.EdgeDetectorParam.edgeTest		= false; 
	Dataset.EdgeDetectorParam.thresh		= 0.45; 
	Dataset.HoughParam.fillGap 				= 10;
	Dataset.HoughParam.minLength 			= 45; 
elseif strcmp(DatasetName, 'SpilFrontal6345') == 1
	Dataset.fileShort 						= 'SpilFrontal6345_crop1';
	Dataset.path 							= [startPathDataset,'Spil/SpilFrontal/'];
	%Dataset.cropArea						= [1,1,550,1632] %y1,x1,y2,x2
	Dataset.cropArea						= [1,1,550,1629] %y1,x1,y2,x2
	Dataset.baseFile 						= 'IMG_6345_crop1'
	Dataset.colorModel						= 'BW'; % {'HSV_V','RGB','BW', 'ORIGINAL'	};
	Dataset.EdgeDetectorParam.thresh		= 0.35; 
	Dataset.EdgeDetectorParam.edgeTest 		= false;
	% orthogonal values
	Dataset.HoughParam.ThetaH.Resolution  	= 0.1;
	Dataset.HoughParam.ThetaV.Resolution  	= Dataset.HoughParam.ThetaH.Resolution;
	Dataset.HoughParam.ThetaH.stretchAngle	= 5;
	Dataset.HoughParam.ThetaV.stretchAngle	= 5;
else
	error('no matching dataset name');
end

% set defaults after

% if start nr exist convert to str, else empty string
if isfield(Dataset, 'imStartNr') == 1
	imStartNrStr = int2str(Dataset.imStartNr);
else
	imStartNrStr = '';
end

ImReader.file = [Dataset.path, Dataset.baseFile, imStartNrStr, Dataset.postfix]

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

% generate parameter string
Dataset.paramStr = getParamStr(Dataset);



plotme = true;
plotmeImEdge = false;
plotmeImOri = false;
plotmeImHough = true;

plotmeImHibaap = true; % todo doesnt work


%modulesPlotEps = {'ImReader','HoughResult', 'Hibaap', 'ClassRect'}
modulesPlotEps =  [        0,             0,       0,           0];

% MODULE THINGY 
if exist('modules') == 0
	modules = {'ImReader','HoughResult','Projection'}
end
for iM=1:length(modules)
	module = modules{iM}; modulePretty = ['[',module,'] '];
	loadStr = strcat(startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_',module,'.mat')
	if exist(loadStr) == 0
		disp([modulePretty,'LOADABLE FILE FOUND : [NO]']);
		defaultReply = 'n';
	else
		disp([modulePretty,'LOADABLE FILE FOUND : [YES]']);
		defaultReply = 'y';
	end
	reply = input(['[', module,'] get data from cache? y/n [', defaultReply, ']: '], 's');
	if isempty(reply)
		reply = defaultReply
	end
	if reply=='y'
		% load module from cache
		fprintf('\nLOADING %s',loadStr), load(loadStr), fprintf(' ... [DONE]\n\n\n');
	else
		% generate script (get live data)
		eval(['get',module]);
	end
	% attach module to dataset
	evalStr = ['Dataset.',module,' = ', module]
	eval(evalStr);
	disp('[DONE]');

	if modulesPlotEps(iM)==1
		if plotme
			disp('SAVING EPS..');
			evalCode = ['export_fig -eps ', savePathEps, 'w_', Dataset.fileShort, '_Im', module, '.eps'], eval(evalCode)
			disp('[DONE]');
		end
	end
	% save ori image
	if strcmp(module,'ImReader') && plotmeImOri
		disp('SAVING IM ORI EPS..');
		figure; imshow(Dataset.ImReader.imOri);
		evalCode = ['export_fig -eps ', savePathEps, 'w_', Dataset.fileShort, '_ImOri.eps'], eval(evalCode)
		figure; imshow(Dataset.ImReader.imEdge);
		evalCode = ['export_fig -eps ', savePathEps, 'w_', Dataset.fileShort, '_ImEdge.eps'], eval(evalCode)
		disp('[DONE]');
	end
	if strcmp(module,'ClassRect') 
		disp('SAVING ImClassRectGrayscaleProb ..');
		figure; imshow(Dataset.ClassRect.imGrayscaleProb,[]);
		evalCode = ['export_fig -eps ', savePathEps, 'w_', Dataset.fileShort, '_ImClassRectGrayscaleProb.eps'], eval(evalCode)
		disp('[DONE]');
	end
end


