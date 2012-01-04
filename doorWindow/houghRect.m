close all;
clear WindowsMerged
% load projected
load('../project2Normal/Houghlines.mat');
load('../project2Normal/HoughlinesRot.mat');
% todo remove Y bug in output of project2normal
Houghlines = scaleHoughlines(Houghlines,1000);
HoughlinesRot = scaleHoughlines(HoughlinesRot,1000);

%load('mats/Houghlines_floriande5447.mat');
%load('mats/HoughlinesRot_floriande5447.mat');


plotme = 1;
%cornerInlierThreshold = 0.025
cornerInlierThreshold = 20;
cornerInlierThreshold = 35;
disp('getting cCorners..')
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme);
% TODO fix scaleup for scales =! 1
%disp('getting Harris corners..')
%cornerScaleAccu = getCorners(plotme);
%cCornerHarrisThreshold = 30; scale = 1;
% loop through Harris features and add evidence for close cCorners
%disp('filtering on Harris corners..')
%Houghlines = cCornerHarrisEvidence(Houghlines, cornerScaleAccu, scale, cCornerHarrisThreshold);
%fg = figure(3);clf;hold on;
plotme = 0;
disp('cCornerToWindow..');
[Houghlines, Windows, WindowsIm] = cCornerToWindow(Houghlines,HoughlinesRot,plotme);

disp('plot cCorners..');
plotcCorners(Houghlines,HoughlinesRot)

disp('plotting windows ccorner style');
%figure;
%hold on;
%plotcCornerWindows(Houghlines, HoughlinesRot)



slidingWindowSize = 21
stepSize = 15;
paramStr = ['slidingWindow_Size_',num2str(slidingWindowSize) ,'_StepSize_',num2str(stepSize)]
[WindowsMerged,nrWindowsMax]  = mergeWindows(Windows,slidingWindowSize, stepSize)
plotWindows(WindowsMerged,nrWindowsMax)


reply = input('Save result as images? y/n [n]: ', 's');
if isempty(reply)
	reply = 'n';
end
if reply=='y'
	disp('saving images..');
	% save images
	saveas(fg,['resultsWindow/doorWindow_',paramStr],'png');
	disp('done');
end

% opzich is een gauss snel maar dan moet je peaks eruithalen en ben je de breedte en hoogte window kwijt

% n = 21;
% figure;imshow(WindowsIm,[])
% I2=imfilter(WindowsIm, repmat(1,n,n));
% figure;imshow(I2,[])
% 
% I3=imfilter(WindowsIm, fspecial('gaussian',[n n]));
% for i=1:70
% 	I3=imfilter(I3, fspecial('gaussian',[n n]));
% end
% figure;imshow(I3,[]);


% 1 middelpunt per cluster kiezen
% van dat cluster adhv nxn filter de gemiddelde height en width berekenen
% running avg maken per pixel?
% ixjx3 matrix (pixelY, pixelX, avg width, avg height,vote count)
