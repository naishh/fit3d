close all;
clear WindowsMerged
% load projected
load('../project2Normal/Houghlines.mat');
load('../project2Normal/HoughlinesRot.mat');
projectionScale = 1000;
xOffset = 586;
plotme = 1;
%cornerInlierThreshold = 0.025
cornerInlierThreshold = 35;

% TODO remove Y bug in output of scaleHoughlines
Houghlines = scaleHoughlines(Houghlines,projectionScale,xOffset);
HoughlinesRot = scaleHoughlines(HoughlinesRot,projectionScale,xOffset);
%load('mats/Houghlines_floriande5447.mat');
%load('mats/HoughlinesRot_floriande5447.mat');

disp('getting cCorners..')
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme);

disp('plotting complete windows'); figure; hold on; 
plotcCorners(Houghlines, HoughlinesRot)






% TODO fix scaleup for scales =! 1
% disp('getting Harris corners..')
% get harris corners
% cornerScaleAccu = getCorners(plotme);
% project harris corners
%scale = 1;
%cornerScaleAccu = project2square(cornerScaleAccu,scale,projectionScale);
%plotCornerHarris(cornerScaleAccu,'g+');

%cCornerHarrisThreshold = 30; 
%cCornerHarrisThreshold =  cCornerHarrisThreshold * projectionScale;
% loop through Harris features and add evidence for close cCorners
%disp('filtering on Harris corners..')
%Houghlines = cCornerHarrisEvidence(Houghlines, cornerScaleAccu, scale, cCornerHarrisThreshold);

fg = figure(1);hold on;
plotme = 0;
disp('cCornerToWindow..');
% todo onderstaand weg?
%[Houghlines, Windows, WindowsIm] = cCornerToWindow(Houghlines,HoughlinesRot,plotme);




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

