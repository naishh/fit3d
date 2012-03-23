% runs setup first!
close all;
cd ../../;setup;cd doorWindow/cCorner_and_Harris

cache = false;

%load('Dataset_antwerpen_6223_crop1.mat');
if ~cache
	modules = {'ImReader','HoughResult'}
	%Dataset = getDataset('Floriande3flip',startPath,modules)
	%Dataset = getDataset('Spil6',startPath,modules)
	Dataset = getDataset('Spil6crop1',startPath,modules)
	%Dataset = getDataset('Dirk5',startPath,modules)
	%Dataset = getDataset('Dirk5',startPath,modules)
	Houghlines = Dataset.HoughResult.Houghlines; HoughlinesRot = Dataset.HoughResult.HoughlinesRot
end


%% Dirk 6
%maxWindowSize = 250;
%cornerInlierThreshold = 0.2
%cCornerHarrisThreshold = 30; 

% Dirk 5
%maxWindowSize = 150;
%cornerInlierThreshold = 0.2;
%cCornerHarrisThreshold = 30; 
% Dirk 5
maxWindowSize = 250;
cornerInlierThreshold = 0.2;
cCornerHarrisThreshold = 30; 


% cCornerHarrisThreshold =  cCornerHarrisThreshold * Dataset.projectionScale;
% disp('getting and plotting Harris corners..')
% plotme = 1; cornerScaleAccu = getHarrisCorners(plotme, Dataset.imColorModelTransform);
% plotCornerHarris(cornerScaleAccu,'g+');

% err
% % loop through Harris features and add evidence for close cCorners
% %disp('filtering on Harris corners..')
% %Houghlines = cCornerHarrisEvidence(Houghlines, cornerScaleAccu, 1, cCornerHarrisThreshold);

%imshow(Dataset.imOri);hold on;

disp('getting cCorners..')
tic
if ~cache
	Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold,maxWindowSize);
end
disp('done..')
toc;


if exist('Houghlines') == 0
	load Houghlines
end


plotmeEps = true;
module = 'cCorner'
savePathEps = '../resultsEps/'


% todo remove this  
%Houghlines2 = Houghlines(1:30)
Houghlines2 = Houghlines;

figure; imshow(Dataset.ImReader.imOriDimmed)

%HoughlinesFiltered  = filtercCorner(Houghlines2);

figure; imshow(Dataset.ImReader.imOriDimmed)
plotcCorners(Houghlines2, HoughlinesRot, 'cCornerConnectivity',0)
if plotmeEps 
	disp('SAVING EPS..');
	type = 'cCorner';
	evalCode = ['export_fig -eps ', savePathEps, 'w_', Dataset.fileShort, '_Im', module, '_', type, '.eps'], eval(evalCode);
	disp('[DONE]');
end

figure; imshow(Dataset.ImReader.imOriDimmed)
plotcCorners(Houghlines2, HoughlinesRot, 'windowFilled',0)
if plotmeEps 
	disp('SAVING EPS..');
	type = 'windowFilled';
	evalCode = ['export_fig -eps ', savePathEps, 'w_', Dataset.fileShort, '_Im', module, '_', type, '.eps'], eval(evalCode);
	disp('[DONE]');
end


%filtercCornerkMeans(Houghlines2);

if exist('HoughlinesFiltered') == 1
	figure; imshow(Dataset.ImReader.imOriDimmed)
	plotcCorners(HoughlinesFiltered, HoughlinesRot, 'cCorner',0)
end


% figure; imshow(Dataset.ImReader.imOriDimmed)
% plotcCorners(Houghlines2, HoughlinesRot, 'window',0)




% project harris corners
%cornerScaleAccu = project2square(cornerScaleAccu,1,Dataset.HoughParam.projectionScale);


%reply = input('Save result as images? y/n [n]: ', 's');
%if isempty(reply)
%	reply = 'n';
%end
%if reply=='y'
%	disp('saving images..');
%	% save images
%	saveas(fg,['resultsWindow/doorWindow_',paramStr],'png');
%	disp('done');
%end

