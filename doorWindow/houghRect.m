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
load('mats/Houghlines_floriande5435.mat');
load('mats/HoughlinesRot_floriande5435.mat');
projectionScale = 1; xOffset = 0;
cornerInlierThreshold = 0.2

%fg = figure(1);hold on;


disp('getting cCorners..')
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold);


disp('getting and plotting Harris corners..')
plotme = 1; cornerScaleAccu = getCorners(plotme);

disp('plotting complete windows'); 
plotcCorners(Houghlines, HoughlinesRot)

% project harris corners
%scale = 1;
%cornerScaleAccu = project2square(cornerScaleAccu,scale,projectionScale);
%plotCornerHarris(cornerScaleAccu,'g+');

%cCornerHarrisThreshold = 30; 
%cCornerHarrisThreshold =  cCornerHarrisThreshold * projectionScale;
% loop through Harris features and add evidence for close cCorners
%disp('filtering on Harris corners..')
%Houghlines = cCornerHarrisEvidence(Houghlines, cornerScaleAccu, scale, cCornerHarrisThreshold);

plotme = 0;




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

