close all;
clear WindowsMerged
% % load projected
% %load('../project2Normal/Houghlines.mat');
% %load('../project2Normal/HoughlinesRot.mat');
% projectionScale = 1000; xOffset = 586; cornerInlierThreshold = 1;
% % TODO remove Y bug in output of scaleHoughlines
% Houghlines = scaleHoughlines(Houghlines,projectionScale,xOffset);
% HoughlinesRot = scaleHoughlines(HoughlinesRot,projectionScale,xOffset);

% load unprojected houghlines
%load('mats/Houghlines_floriande5435.mat');
%load('mats/HoughlinesRot_floriande5435.mat');

fileShort = 'spilrect6';
file = '../dataset/datasetSpil/datasetSpilRect/P_rect6_Hflipped.jpg';
im = imread(file); imshow(im);
%imshow(imread('../dataset/datasetSpil/datasetSpilRect/P_rect6.jpg'));
hold on;
load(['mats/Houghlines_',fileShort,'.mat']);
load(['mats/HoughlinesRot_',fileShort,'.mat']);


projectionScale = 1; xOffset = 0;
cornerInlierThreshold = 0.2
maxWindowSize = 200;
scale = 1;

cCornerHarrisThreshold = 30; 
cCornerHarrisThreshold =  cCornerHarrisThreshold * projectionScale;



disp('getting and plotting Harris corners..')
plotme = 1; cornerScaleAccu = getCorners(plotme, im);
err
% loop through Harris features and add evidence for close cCorners
disp('filtering on Harris corners..')
Houghlines = cCornerHarrisEvidence(Houghlines, cornerScaleAccu, scale, cCornerHarrisThreshold);

disp('getting cCorners..')
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold,maxWindowSize);



disp('plotting complete windows'); 
plotcCorners(Houghlines, HoughlinesRot)

% project harris corners
%scale = 1;
%cornerScaleAccu = project2square(cornerScaleAccu,scale,projectionScale);
%plotCornerHarris(cornerScaleAccu,'g+');





% sliding window ding
% figure;hold on;
% slidingWindowSize = 21
% stepSize = 15;
% paramStr = ['slidingWindow_Size_',num2str(slidingWindowSize) ,'_StepSize_',num2str(stepSize)]
% [WindowsMerged,nrWindowsMax]  = mergeWindows(Windows,slidingWindowSize, stepSize)
% plotWindows(WindowsMerged,nrWindowsMax)

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

