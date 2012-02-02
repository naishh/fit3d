% HIBAAP - HIstogram BAsed AProach, window detection
close all;
tic;
%Dataset.fileShort = 'OrtCrop1';
%load([startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_houghlinesVH.mat']);

disp('plotting houghlines');
	fgHough = figure();imshow(Dataset.imOriDimmed); hold on;
	plotHoughlinesAll(Dataset.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);
	fgHist= figure();imshow(Dataset.imOriDimmed); hold on;

% get coords of endpoints of houghlines
[Xv, Yv] = houghlinesToXY(Dataset.HoughResult.Houghlines);
[Xh, Yh] = houghlinesToXY(Dataset.HoughResult.HoughlinesRot);

% calc histograms
XvBins = 1:1:Dataset.imWidth; XvHist = hist(Xv,XvBins);
YhBins = 1:1:Dataset.imHeight; YhHist = hist(Yh,YhBins);
% 'unusable' histograms
% YvBins = 1:1:Dataset.imHeight; YvHist = hist(Yv,YvBins);
% XhBins = 1:1:Dataset.imWidth; XhHist = hist(Xh,XhBins);

% smooth histograms 
incrFactor = Dataset.HibaapParam.incrFactor; % TODO make perncent of avg image width height
XvHistSmooth = smoothNtimes(XvHist,6);
YhHistSmooth = smoothNtimes(YhHist,6);

% plot histograms
disp('plotting histograms');
%plot(incrFactor*XvHist,'y-');
plotHistX(Dataset.imHeight, XvBins, (incrFactor*XvHist));
plotHistY(incrFactor*YhHist, YhBins);

% plot histograms smoothed
plot(XvBins, Dataset.imHeight-(incrFactor*XvHistSmooth),'r-', 'LineWidth',2);
plot(incrFactor*YhHistSmooth, YhBins, 'r-', 'LineWidth',2);

% set histogram thresholds
XvThresh = Dataset.HibaapParam.XvThresh; YhThresh = Dataset.HibaapParam.YhThresh;

% plot horizontal threshold line
plot([0 Dataset.imWidth],[Dataset.imHeight-(incrFactor*XvThresh), Dataset.imHeight-(incrFactor*XvThresh)],'k--','LineWidth',2); 
% plot vertical threshold line
plot([incrFactor*YhThresh,incrFactor*YhThresh], [0,Dataset.imHeight],'k--','LineWidth',2);

% find peaks
plotme = 1;
XvHistMaxPeaks = getHistMaxPeaks(Dataset, XvHistSmooth, XvThresh, plotme,'Xv');
YhHistMaxPeaks = getHistMaxPeaks(Dataset, YhHistSmooth, YhThresh, plotme,'Yh');
% save result in dataset
Dataset.Hibaap.XvHistMaxPeaks = XvHistMaxPeaks;
Dataset.Hibaap.YhHistMaxPeaks = YhHistMaxPeaks;

% find and plot intersections of vertical and horizontal lines
EdgePeakCrossings = [];
for i=1:length(XvHistMaxPeaks)
	for j=1:length(YhHistMaxPeaks)
		[crossing,d,l1,l2] = getLineCrossing([XvHistMaxPeaks(i),0]',[XvHistMaxPeaks(i),Dataset.imHeight]',[0,YhHistMaxPeaks(j)]',[Dataset.imWidth,YhHistMaxPeaks(j)]');
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


saveStr = [startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_hibaap.mat'];
save(saveStr, 'Dataset');
saveStr, disp('saved');


% RECTANGLE CLASSIFICATION by cCorner
%hibaapcCorner(Dataset)


% RECTANGLE CLASSIFICATION
%saveImage = false
%hibaapClassifyRectangles(Dataset,saveImage)



toc;
