% HIBAAP - HIstogram BAsed AProach, window detection
close all;
tic;
%Dataset.fileShort = 'OrtCrop1';
%load([startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_houghlinesVH.mat']);

disp('plotting houghlines');
	% fgHough = figure();imshow(Dataset.ImReader.imOriDimmed); hold on;
	% plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);
	fgHist= figure();imshow(Dataset.ImReader.imOriDimmed); hold on;

w = Dataset.ImReader.imWidth;
h = Dataset.ImReader.imHeight;


%Yalignment =

% X = [48.5102   21.0729];
% Y = [26.9576  781.2898];
% plot(X,Y,'r--')
% 
% Y = Dataset.ImReader.imHeight-Y
% Xd = X(1)-X(2)
% Yd = Y(1)-Y(2)
% angle = acos(Yd/Xd)
% 
% Y(1)/cos(angle) 
% err

graphSpacing = 100;

% METHOD 1: houghline endpoints
% get coords of endpoints of houghlines
[Xv, Yv] = houghlinesToXY(Dataset.HoughResult.Houghlines);
[Xh, Yh] = houghlinesToXY(Dataset.HoughResult.HoughlinesRot);

% setup histograms bins
XvBins = 1:1:w;
YhBins = 1:1:h;
% 'unusable' histograms
YvBins = 1:1:h;
XhBins = 1:1:w;

% calc histograms
XvHist = hist(Xv,XvBins);
YhHist = hist(Yh,YhBins);
% 'unusable' histograms
YvHist = hist(Yv,YvBins);
XhHist = hist(Xh,XhBins);

% smooth histograms 
XvHistSmooth = smoothNtimes(XvHist,6); XhHistSmooth = smoothNtimes(XhHist,6); YhHistSmooth = smoothNtimes(YhHist,6); YvHistSmooth = smoothNtimes(YvHist,6);
incrFactor = 0.1;
% normalise to get AWESOME graph height
XvHistSmooth = (XvHistSmooth/max(XvHistSmooth))*incrFactor*h;
XhHistSmooth = (XhHistSmooth/max(XhHistSmooth))*incrFactor*h;
YvHistSmooth = (YvHistSmooth/max(YvHistSmooth))*incrFactor*w;
YhHistSmooth = (YhHistSmooth/max(YhHistSmooth))*incrFactor*w;

%plot(incrFactor*XvHist,'y-');
%plotHistX(Dataset.ImReader.imHeight, XvBins, (incrFactor*XvHist), 'g-');
%plotHistX(Dataset.ImReader.imHeight-graphSpacing, XhBins, (incrFactor*XhHist), 'r-');
%plotHistY(incrFactor*YhHist, YhBins);

% plot histograms smoothed
plot(XvBins, Dataset.ImReader.imHeight-XvHistSmooth,'r-', 'LineWidth',2);
pause;
plot(XhBins, Dataset.ImReader.imHeight-graphSpacing-XhHistSmooth,'g-', 'LineWidth',2);
pause;


%------------------------------------------------------------------------------------------------------------
disp('method 2 METHOD 2: all px on houghline');
pause;
%METHOD 2: all px on houghline');
% calc histograms by summing rows/cols
XvHist = sum(HoughResult.V.Im);
YvHist = sum(HoughResult.V.Im, 2);
XhHist = sum(HoughResult.H.Im);
YhHist = sum(HoughResult.H.Im, 2);


% smooth histograms 
XvHistSmooth = smoothNtimes(XvHist,6); XhHistSmooth = smoothNtimes(XhHist,6); YhHistSmooth = smoothNtimes(YhHist,6); YvHistSmooth = smoothNtimes(YvHist,6);
% normalise to get AWESOME graph height
XvHistSmooth = (XvHistSmooth/max(XvHistSmooth))*incrFactor*h;
XhHistSmooth = (XhHistSmooth/max(XhHistSmooth))*incrFactor*h;
YvHistSmooth = (YvHistSmooth/max(YvHistSmooth))*incrFactor*w;
YhHistSmooth = (YhHistSmooth/max(YhHistSmooth))*incrFactor*w;

% plot histograms
disp('plotting histograms');
%plot(incrFactor*XvHist,'y-');

%plotHistX(Dataset.ImReader.imHeight-2*graphSpacing, XvBins, (incrFactor*XvHist), 'g-');
%plotHistX(Dataset.ImReader.imHeight, XhBins, (incrFactor*XhHist), 'r-');
%plotHistY(incrFactor*YhHist, YhBins, 'g-');
%plotHistY(incrFactor*YvHist, YvBins, 'r-');

% plot histograms smoothed
plot(XvBins, Dataset.ImReader.imHeight-2*graphSpacing-XvHistSmooth,'r-', 'LineWidth',2);
pause;
plot(XhBins, Dataset.ImReader.imHeight-2*graphSpacing-XhHistSmooth,'g-', 'LineWidth',2);
%plot(2*graphSpacing + incrFactor*YhHistSmooth, YhBins, 'r-', 'LineWidth',2);
%plot(2*graphSpacing + incrFactor*YvHistSmooth, YhBins, 'g-', 'LineWidth',2);

% set histogram thresholds
XvThresh = Dataset.HibaapParam.XvThresh; YhThresh = Dataset.HibaapParam.YhThresh;

% plot horizontal threshold line
plot([0 Dataset.ImReader.imWidth],[Dataset.ImReader.imHeight-(incrFactor*XvThresh), Dataset.ImReader.imHeight-(incrFactor*XvThresh)],'k--','LineWidth',2); 
% plot vertical threshold line
%plot([incrFactor*YhThresh,incrFactor*YhThresh], [0,Dataset.ImReader.imHeight],'k--','LineWidth',2);

pause;
%------------------------------------------------------------------------------------------------------------------------
% find peaks
plotme = 1;
XvHistMaxPeaks = getHistMaxPeaks(Dataset, XvHistSmooth, XvThresh, plotme,'Xv');
YhHistMaxPeaks = getHistMaxPeaks(Dataset, YhHistSmooth, YhThresh, plotme,'Yh');
% save result in dataset
Hibaap.XvHistMaxPeaks = XvHistMaxPeaks;
Hibaap.YhHistMaxPeaks = YhHistMaxPeaks;

% find and plot intersections of vertical and horizontal lines
EdgePeakCrossings = [];
for i=1:length(XvHistMaxPeaks)
	for j=1:length(YhHistMaxPeaks)
		[crossing,d,l1,l2] = getLineCrossing([XvHistMaxPeaks(i),0]',[XvHistMaxPeaks(i),Dataset.ImReader.imHeight]',[0,YhHistMaxPeaks(j)]',[Dataset.ImReader.imWidth,YhHistMaxPeaks(j)]');
		plot(crossing(1), crossing(2), '+k');
		EdgePeakCrossings = [EdgePeakCrossings;crossing'];
	end
end


saveImage = false;
if saveImage
	disp('saving images..');
	savePath 						= ['resultsHibaap/',Dataset.fileShort,'/'];
	% if dir doesnt exist make it 
	if exist(savePath) == 0
		mkdir(savePath);
	end
	% TODO
	% use hgexport for eps images report thesis !
	% save images
	saveas(fgHough 				,[savePath,'03_fgHough.png'],'png'); 
	saveas(fgHist 				,[savePath,'04_fgHist.png'],'png'); 
	disp('done!');
end


saveStr = [startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_Hibaap.mat'];
save(saveStr, 'Hibaap');
saveStr, disp('saved');


% RECTANGLE CLASSIFICATION by cCorner
%hibaapcCorner(Dataset)


% RECTANGLE CLASSIFICATION
%saveImage = false
%hibaapClassifyRectangles(Dataset,saveImage)



toc;
