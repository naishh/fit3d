% this file does edge and houghline extraction
%
close all;
tic;

DatasetFromCache				= false
edgeFromCache					= false
edgeTest 						= false
saveImageQ						= true

plotme							= true;

if ~DatasetFromCache
	%Dataset 						= getDataset('Antwerpen_6220',startPath);
	%Dataset 						= getDataset('Antwerpen_6223_crop1',startPath);
	%Dataset 						= getDataset('Antwerpen_6220_crop2',startPath);
	%Dataset 						= getDataset('Spil1Trans',startPath);
	%Dataset 						= getDataset('Spil1TransCrop2',startPath);
	Dataset 						= getDataset('Ort1',startPath);
	%Dataset 						= getDataset('OrtCrop1',startPath)
	%Dataset 						= getDataset('Spil1TransCrop1',startPath);
	paramStr 						= getParamStr(Dataset);
end


% TODO BLUR
% TODO houghlines fillgab uitzetten in image


% read file
Dataset.imOri 					= imread(Dataset.file);
Dataset.imOriDimmed 			= 0.8*Dataset.imOri;
Dataset.imHeight 				= size(Dataset.imOri, 1);
Dataset.imWidth					= size(Dataset.imOri, 2);

if ~edgeFromCache
	% transform color
	imColorModelTransform   = getColorModelTransform(Dataset.imOri, Dataset);
	% perform edge detection
	Dataset.imColorModelTransform 	= imColorModelTransform;
	imEdge = getEdge(Dataset, edgeTest);
end

Dataset.imColorModelTransform 	= imColorModelTransform;
Dataset.imEdge					= imEdge;

fgColorModelTransform = figure();imshow(Dataset.imColorModelTransform);
fgEdge = figure();imshow(Dataset.imEdge);


% HOUGHLINES:
fgHough = figure(); 
imshow(Dataset.imOriDimmed); 
hold on;

% HOUGHLINES VERTICAL:
[H,Theta,Rho] = hough(imEdge,'Theta',Dataset.HoughParam.ThetaV.Start:Dataset.HoughParam.ThetaV.Resolution:Dataset.HoughParam.ThetaV.End);
Peaks  = houghpeaks(H,Dataset.HoughParam.nrPeaks,'threshold',ceil(Dataset.HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
Dataset.Houghlines = houghlines(imEdge,Theta,Rho,Peaks,'FillGap',Dataset.HoughParam.fillGap,'MinLength',Dataset.HoughParam.minLength);

% HOUGHLINES ROTATED (HORIZONTAL):
imEdgeRot    = rot90(imEdge,-1);
[H,Theta,Rho] = hough(imEdgeRot,'Theta',Dataset.HoughParam.ThetaH.Start:Dataset.HoughParam.ThetaH.Resolution:Dataset.HoughParam.ThetaH.End);
Peaks  = houghpeaks(H,Dataset.HoughParam.nrPeaks,'threshold',ceil(Dataset.HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
Dataset.HoughlinesRot = houghlines(imEdgeRot,Theta,Rho,Peaks,'FillGap',Dataset.HoughParam.fillGap,'MinLength',Dataset.HoughParam.minLength);
Dataset.HoughlinesRot = flipHoughlinesRot(Dataset.HoughlinesRot, Dataset.imHeight);

%HOUGHLINES PLOT
plotHoughlinesAll(Dataset.imHeight,Dataset.Houghlines,Dataset.HoughlinesRot)


toc;

if saveImageQ
	reply = input('Save Dataset and images? y/n [n]: ', 's');
	if isempty(reply)
		reply = 'n';
	end
	if reply=='y'
		disp('saving Dataset and images ..');
		savePathFile 						= ['results/',Dataset.fileShort];
		% save images
		saveas(fgColorModelTransform,[savePathFile,'_colortransform__',paramStr],'png');
		saveas(fgEdge,[savePathFile,'_edge__',paramStr],'png');
		saveas(fgHough,[savePathFile,'_hough__',paramStr],'png');
		% update dataset vals
		saveStr = [startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_houghlinesVH.mat'];
		save(saveStr, 'Dataset');
		saveStr, disp('saved');
	end
end

% new plan
% transform edge image to rectangular image
%	apply hough rectangul detection based on hough transform (paper)
% make dummy image where some rectangles are present
% unblurr or something like that to make edgelines more thick
% apply a houghline length range (max and min), 
% use a height-width ratio for windows
% detect cornerpoints by houghline intersection
% 	detect exact intersections
% 	stretch exact intersection by making all lines just a little bit longer
%		search old paper for auto connect line parts
% play with a (harris?) cornerdetector
% read paper about implicite shape of window
%	use assumptions, like average width height ratio of the window




% OLD CODE:
%
% FILTER HOUGHLINES
% 1---2
% |   |
% 4---3
% '../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', 5432
% X = [679.5000, 871.5000, 871.5000, 677.5000];
% Y = [185.5000, 301.5000, 675.5000, 699.5000];
% use [X,Y] =  ginput(4) and store XY in a mat format
% calculates the angle of the upper and bottom wallline segment
% (in orde to provide the angle interval)
% theta1 = calcHoughTheta(X(1),Y(1),X(2),Y(2),h)
% theta2 = calcHoughTheta(X(3),Y(3),X(4),Y(4),h)
