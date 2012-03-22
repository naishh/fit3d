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
	Houghlines = Dataset.HoughResult.Houghlines; HoughlinesRot = Dataset.HoughResult.HoughlinesRot
end

maxWindowSize = 150;
cornerInlierThreshold = 0.2
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


if exist('Houghlines') == 0
	load Houghlines
end




% todo remove this  
%Houghlines2 = Houghlines(1:30)
Houghlines2 = Houghlines;

disp('plotting complete windows'); 
figure; imshow(Dataset.ImReader.imOriDimmed)
plotcCorners(Houghlines2, HoughlinesRot, 'window',0)

%HoughlinesFiltered  = filtercCorner(Houghlines2);
filtercCornerkMeans(Houghlines2);


%if exist('HoughlinesFiltered') == 1
%	figure; imshow(Dataset.ImReader.imOriDimmed)
%	%plotcCorners(HoughlinesFiltered, HoughlinesRot, 'cCorner',0)
%	plotcCorners(HoughlinesFiltered, HoughlinesRot, 'window',0)
%end


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

