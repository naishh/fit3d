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


graphSpacing = 100;
incrFactor = 0.2;


% setup histograms bins
XvBins = 1:1:w;
YhBins = 1:1:h;
% 'unusable' histograms
YvBins = 1:1:h;
XhBins = 1:1:w;

disp('method 2 METHOD 2: all px on houghline');
%METHOD 2: all px on houghline');
% calc histograms by summing rows/cols
XvHist = sum(HoughResult.V.Im);
YvHist = sum(HoughResult.V.Im, 2);
XhHist = sum(HoughResult.H.Im);
YhHist = sum(HoughResult.H.Im, 2);

% smooth histograms 
XvHistSmooth = smoothNtimes(XvHist,6); XhHistSmooth = smoothNtimes(XhHist,6); YhHistSmooth = smoothNtimes(YhHist,6); YvHistSmooth = smoothNtimes(YvHist,6);
% normalise to get AWESOME graph height

% mark positions where XhHistSmooth in or decreases big time by taking the abs diff
%XhHistSmoothDer = abs(diff(XhHistSmooth));
XhHistSmoothDer = abs(diff(XhHist))';
l=length(XhHistSmoothDer); XhHistSmoothDer(l+1) = XhHistSmoothDer(l);
XhHistSmoothDer = smoothNtimes(XhHistSmoothDer,6);


%XhvHistSmooth = (0.8*XvHistSmooth + 0.2*XhHistSmoothDer)/2;
%XhvHistSmooth = smoothNtimes(XhvHistSmooth,6);

% stretch graphs 
XvHistSmooth = (XvHistSmooth/max(XvHistSmooth))*incrFactor*h;
XhHistSmooth = (XhHistSmooth/max(XhHistSmooth))*incrFactor*h;
XhHistSmoothDer = (XhHistSmoothDer/max(XhHistSmoothDer))*incrFactor*h;

XhvHistSmooth = (XvHistSmooth + XhHistSmoothDer)/2;

YvHistSmooth = (YvHistSmooth/max(YvHistSmooth))*incrFactor*w;
YhHistSmooth = (YhHistSmooth/max(YhHistSmooth))*incrFactor*w;

XhHistSmoothDer = XhHistSmoothDer * 2; 

% if the pseudo peak is above the XvHistSmooth plot it else plot XvHistSmooth
Xpseudo = XhHistSmoothDer - XvHistSmooth;
% quickfix:remove tale that peaks enormous because of smoothing avg
Xpseudo = Xpseudo(1:(length(Xpseudo)-10));
XhHistSmoothDer = XhHistSmoothDer(1:(length(XhHistSmoothDer )-10));

% XhPseudo = max(XvHistSmooth, Xpseudo);

%todo..
XclassifyReady = XvHistSmooth; 

% plot histograms
disp('plotting histograms');
%plot(incrFactor*XvHist,'y-');

%plotHistX(Dataset.ImReader.imHeight-2*graphSpacing, XvBins, (incrFactor*XvHist), 'g-');
%plotHistX(Dataset.ImReader.imHeight, XhBins, (incrFactor*XhHist), 'r-');
%plotHistY(incrFactor*YhHist, YhBins, 'g-');
%plotHistY(incrFactor*YvHist, YvBins, 'r-');

% plot histograms smoothed
plot(XhBins, Dataset.ImReader.imHeight-6*graphSpacing-XhHistSmooth,'y-', 'LineWidth',2);
plot(XhBins(1:length(XhHistSmoothDer)), Dataset.ImReader.imHeight-6*graphSpacing-XhHistSmoothDer,'b-', 'LineWidth',2);
plot(XvBins, Dataset.ImReader.imHeight-3*graphSpacing-XvHistSmooth,'g-', 'LineWidth',2);
plot(XhBins(1:length(Xpseudo)), Dataset.ImReader.imHeight-3*graphSpacing-Xpseudo,'k-', 'LineWidth',2);
%plot(XvBins, Dataset.ImReader.imHeight-6*graphSpacing-XhPseudo,'g-', 'LineWidth',2);
%plot(2*graphSpacing + incrFactor*YhHistSmooth, YhBins, 'r-', 'LineWidth',2);
%plot(2*graphSpacing + incrFactor*YvHistSmooth, YhBins, 'g-', 'LineWidth',2);

legend('Xh: total amount of overlapping horizontal Houghlines at each x position',...
'Xhder: Absolute of derivative of Xh',...
'Xv: total amount of overlapping vertical Houghlines at each x position.',...
'Xpseudo: Xhder - Xv');

% set histogram thresholds
XvThresh = Dataset.HibaapParam.XvThresh; YhThresh = Dataset.HibaapParam.YhThresh;

% plot horizontal threshold line
%plot([0 Dataset.ImReader.imWidth],[Dataset.ImReader.imHeight-(incrFactor*XvThresh), Dataset.ImReader.imHeight-(incrFactor*XvThresh)],'k--','LineWidth',2); 
% plot vertical threshold line
%plot([incrFactor*YhThresh,incrFactor*YhThresh], [0,Dataset.ImReader.imHeight],'k--','LineWidth',2);

pause;
%------------------------------------------------------------------------------------------------------------------------
% find peaks
plotme = 1;
XvThresh = 0.3;
XvHistMaxPeaks = getHistMaxPeaks(Dataset, XvHistSmooth, XvThresh, plotme,'Xv')
pause;
XvThresh = 0.4;
XvHistMaxPeaksPseudo = getHistMaxPeaks(Dataset, XhHistSmoothDer, XvThresh, plotme,'XvPseudo')
XvHistMaxPeaksTotal = sort([XvHistMaxPeaks,XvHistMaxPeaksPseudo])
pause;
YhHistMaxPeaks = getHistMaxPeaks(Dataset, YhHistSmooth, YhThresh, plotme,'Yh');
% save result in dataset
Hibaap.XvHistMaxPeaks = XvHistMaxPeaksTotal;
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
