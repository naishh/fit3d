% HIBAAP - HIstogram BAsed AProach, window detection
% extracts windows based on the pdf of the houghline endpoints in vertical and horizontal direction
% it covers the seperate treatment of vertical and horizontal lines extracted bij the getHoughlinesVH
% it fuses the result of the cCorner aproach
close all;
tic;

if false
%load([startPath,'/doorWindow/mats/Dataset_antwerpen_6223_crop1.mat']);
%load([startPath,'/doorWindow/mats/Dataset_Spil1Trans.mat']);
%load([startPath,'/doorWindow/mats/Dataset_Spil1TransCrop1.mat']);
%load([startPath,'/doorWindow/mats/Dataset_Spil1TransCrop1.mat']);

disp('plotting houghlines');
figure;imshow(Dataset.imOriDimmed); hold on;
plotHoughlinesAll(Dataset.imHeight,Dataset.Houghlines,Dataset.HoughlinesRot);
%figure;imshow(Dataset.imOriDimmed); hold on;

disp('plotting histograms');
% get coords of endpoints of houghlines
[Xv, Yv] = houghlinesToXY(Dataset.Houghlines);
[Xh, Yh] = houghlinesToXY(Dataset.HoughlinesRot);
% figure;
% for i=1:2:length(Xh)-1
% 	plot(Xh(i:i+1),Yh(i:i+1),'r-')
% 	hold on;
% 	pause;
% end

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
%plot(incrFactor*XvHist,'y-');
%plot(XvBins, Dataset.imHeight-(incrFactor*XvHist),'y-');
plotHistX(Dataset.imHeight, XvBins, (incrFactor*XvHist));
%plot(incrFactor*YhHist, YhBins, 'y-');
plotHistY(incrFactor*YhHist, YhBins);

% plot histograms smoothed
plot(XvBins, Dataset.imHeight-(incrFactor*XvHistSmooth),'r-', 'LineWidth',2);
plot(incrFactor*YhHistSmooth, YhBins, 'r-', 'LineWidth',2);

% set histogram thresholds
XvThresh = Dataset.HibaapParam.XvThresh
YhThresh = Dataset.HibaapParam.YhThresh
% plot horizontal threshold line
plot([0 Dataset.imWidth],[Dataset.imHeight-(incrFactor*XvThresh), Dataset.imHeight-(incrFactor*XvThresh)],'k--','LineWidth',2); hold on;
% plot vertical threshold line
plot([incrFactor*YhThresh,incrFactor*YhThresh], [0,Dataset.imHeight],'k--','LineWidth',2);

% find vertical peaks
plotme = 1;
XvHistMaxPeaks = getHistMaxPeaks(Dataset, XvHistSmooth, XvThresh, plotme,'Xv');
YhHistMaxPeaks = getHistMaxPeaks(Dataset, YhHistSmooth, YhThresh, plotme,'Yh');


% find and plot intersections of vertical and horizontal lines
EdgePeakCrossings = [];
for i=1:length(XvHistMaxPeaks)
	for j=1:length(YhHistMaxPeaks)
		[crossing,d,l1,l2] = getLineCrossing([XvHistMaxPeaks(i),0]',[XvHistMaxPeaks(i),Dataset.imHeight]',[0,YhHistMaxPeaks(j)]',[Dataset.imWidth,YhHistMaxPeaks(j)]');
		plot(crossing(1), crossing(2), '+k');
		EdgePeakCrossings = [EdgePeakCrossings;crossing'];
	end
end


% RECTANGLE CLASSIFICATION
% add borders
XvHistMaxPeaks = [1,XvHistMaxPeaks,Dataset.imWidth];
YvHistMaxPeaks = [1,XvHistMaxPeaks,Dataset.imHeight];

end


% TODO iets meer dan randen meenemen, ranges veranderen, uitbreiden
figure;imshow(Dataset.imOriDimmed); hold on;
tempIm = zeros(Dataset.imHeight,Dataset.imWidth,1);
imEdgeCountX = tempIm;
imEdgeCountY = tempIm;
imEdgeCountBinX = tempIm;
imEdgeCountBinY = tempIm;

% loop through vertical strokes
edgeStrokeNormArray = zeros(length(XvHistMaxPeaks),1)
for i=2:length(XvHistMaxPeaks)
	x1 = XvHistMaxPeaks(i-1);
	x2 = XvHistMaxPeaks(i);
	edgeStroke	= Dataset.imEdge(:,x1:x2);
	edgeStrokeTotal= sum(sum(edgeStroke));
	edgeStrokeNorm=edgeStrokeTotal/(size(edgeStroke,1)*size(edgeStroke,2))
	imEdgeCountX(:,x1:x2) = edgeStrokeNorm;
	edgeStrokeNormArray(i-1) = edgeStrokeNorm;
	%imshow(imEdgeCountX,[]); pause;
	if edgeStrokeNorm<=0.033
		binVal = 0;
	else
		binVal = 1;
	end
	imEdgeCountBinX(:,x1:x2) = binVal;
end
edgeStrokeNormArray

% loop through horizontal strokes
edgeStrokeNormArray = zeros(length(YvHistMaxPeaks),1)
for j=2:length(YhHistMaxPeaks)
	y1 = YhHistMaxPeaks(j-1);
	y2 = YhHistMaxPeaks(j);
	edgeStroke	= Dataset.imEdge(y1:y2,:);
	edgeStrokeTotal= sum(sum(edgeStroke));
	edgeStrokeNorm=edgeStrokeTotal/(size(edgeStroke,1)*size(edgeStroke,2))
	imEdgeCountY(y1:y2,:) = edgeStrokeNorm;
	edgeStrokeNormArray(j-1) = edgeStrokeNorm;
	%edgeStrokeNorm, imshow(imEdgeCountY,[]); pause;
	if edgeStrokeNorm<=0.023
		binVal = 0;
	else
		binVal = 1;
	end
	imEdgeCountBinY(y1:y2,:) = binVal;
end

edgeStrokeNormArray
sumBinXBinY 			= imEdgeCountBinX+imEdgeCountBinY;

fgimOri 				= figure();imshow(Dataset.imOri,[]);
fgimEdge 				= figure();imshow(Dataset.imEdge,[]);
fgimEdgeCountX 			= figure();imshow(imEdgeCountX,[]);
fgimEdgeCountBinX  		= figure();imshow(imEdgeCountBinX,[]);
fgimEdgeCountY 			= figure();imshow(imEdgeCountY,[]);
fgimEdgeCountBinY  		= figure();imshow(imEdgeCountBinY,[]);
fgimEdgeCountSum  		= figure();imshow(imEdgeCountX+imEdgeCountY,[]);
fgimEdgeCountBinSum  	= figure();imshow(sumBinXBinY ,[]);
fgimEdgeCountBinSumBin  = figure();imshow(sumBinXBinY==2,[]);

saveImageQ = true;
if saveImageQ
	reply = input('Save result as images? y/n [n]: ', 's');
	if isempty(reply)
		reply = 'n';
	end
	if reply=='y'
		disp('saving images..');
		savePath 						= ['resultsHibaap/classifyRectangles/',Dataset.fileShort,'/'];
		% save images
		saveas(fgimOri 				,[savePath,'00_fgimOri.png'],'png'); 
		saveas(fgimEdge 			,[savePath,'01_fgimEdge.png'],'png'); 
		saveas(fgimEdgeCountX 		,[savePath,'05_fgimEdgeCountX.png'],'png'); 
		saveas(fgimEdgeCountBinX	,[savePath,'10_fgimEdgeCountBinX.png'],'png'); 
		saveas(fgimEdgeCountY 		,[savePath,'15_fgimEdgeCountY.png'],'png'); 
		saveas(fgimEdgeCountBinY	,[savePath,'20_fgimEdgeCountBinY.png'],'png'); 
		saveas(fgimEdgeCountSum		,[savePath,'25_fgimEdgeCountSum.png'],'png'); 
		saveas(fgimEdgeCountBinSum  ,[savePath,'30_fgimEdgeCountBinSum.png'],'png'); 
		saveas(fgimEdgeCountBinSumBin,[savePath,'35_fgimEdgeCountBinSumBin.png'],'png');
		disp('done!');
	end
end
% END rectangle classification ----------------------------------------------------------------------------------


% get cCorners
maxWindowSize = 200;
cornerInlierThreshold = 0.2;%0.2
% TODO transform to cCorner
Dataset.Houghlines = getcCorner(Dataset.Houghlines,Dataset.HoughlinesRot,cornerInlierThreshold,maxWindowSize);

disp('plotting cCorner windows'); 
% new figure
pause; figure;imshow(Dataset.imOriDimmed); hold on;
plotcCorners(Dataset.Houghlines, Dataset.HoughlinesRot, 'cCorner', false)






disp('plotting histograms and cCorner windows fused'); 
pause; figure;imshow(Dataset.imOriDimmed); hold on;

% loop through cCorners and draw window @ 4 nearby crossings from kwadrants
WindowsUnique = cell(0);
w = 1;
for i=1:length(Dataset.Houghlines)
	for k=1:length(Dataset.Houghlines(i).cCorners)
		cCorner = Dataset.Houghlines(i).cCorners(k);
		%plotcCorner(cCorner,'cCorner');
		% get midpoint of cCorner
		winX = cCorner.windowMidpointX;
		winY = cCorner.windowMidpointY;
		% plot blue cross in window
		plot(winX, winY, 'b+');
		%pause;

		% perform quadrant selection
		% gets the edge peak crossings kwadrants with the midpoint of window as origin
		EpcLeft 		= EdgePeakCrossings(EdgePeakCrossings(:,1)<=winX,:);
		EpcLeftTop 		= EpcLeft(EpcLeft(:,2)<=winY,:);
		EpcLeftBottom 	= EpcLeft(EpcLeft(:,2)>winY,:);
		EpcRight 		= EdgePeakCrossings(EdgePeakCrossings(:,1)>winX, :);
		EpcRightTop 	= EpcRight(EpcRight(:,2)<=winY, :);
		EpcRightBottom 	= EpcRight(EpcRight(:,2)>winY, :);

		% minimum four crossings need to be found to create a window
		if size(EpcLeftTop,1)>0 && size(EpcRightTop,1)>0 && size(EpcRightBottom,1)>0 &&size(EpcLeftBottom,1)>0

			% get closest crossing from crossings quadrant selection
			Windows{w}.lt 	 			= getClosestPointInArray([winX,winY],EpcLeftTop);
			Windows{w}.rt 	 			= getClosestPointInArray([winX,winY],EpcRightTop);
			Windows{w}.rb 	 			= getClosestPointInArray([winX,winY],EpcRightBottom);
			Windows{w}.lb 	 			= getClosestPointInArray([winX,winY],EpcLeftBottom);
			Windows{w}.width 			= Windows{w}.rt(1) - Windows{w}.lt(1);
			Windows{w}.height			= Windows{w}.rb(2) - Windows{w}.rt(2);
			Windows{w}.windowMidpointX  = winX;
			Windows{w}.windowMidpointY  = winY;
			% collect coords for window
			X = [Windows{w}.lt(1), Windows{w}.rt(1), Windows{w}.rb(1), Windows{w}.lb(1),Windows{w}.lt(1)];
			Y = [Windows{w}.lt(2), Windows{w}.rt(2), Windows{w}.rb(2), Windows{w}.lb(2),Windows{w}.lt(2)];
			% create unique hash
			Windows{w}.hash = int2str([X,Y]);
			% plot window
			%plot(X, Y, 'g-','LineWidth',4);


			% hash functionality
			foundWindow = false;
			for u=1:length(WindowsUnique);
				if strcmp(WindowsUnique{u}.hash, Windows{w}.hash)
					WindowsUnique{u}.votes = WindowsUnique{u}.votes + 1;
					foundWindow = true;
				end
			end
			% initialize a windowunique entry
			if foundWindow == false
				idx = length(WindowsUnique)+1;
				WindowsUnique{idx} = Windows{w};
				WindowsUnique{idx}.votes = 1;
			end

			w = w + 1;
		else
			disp('no nearby crossings found.. i,k');
			i,k
		end
	end
end

toc



% loop through windows unique and plot them with outliers
%TODO
%mincCornerVotes = Dataset.cCornerParam.minVotes;
mincCornerVotes = 1;
ww = 1;
for w=1:length(WindowsUnique)
	WindowsUnique{w}.votes
	% collect coords for windowsUnique
	X = [WindowsUnique{w}.lt(1), WindowsUnique{w}.rt(1), WindowsUnique{w}.rb(1), WindowsUnique{w}.lb(1),WindowsUnique{w}.lt(1)];
	Y = [WindowsUnique{w}.lt(2), WindowsUnique{w}.rt(2), WindowsUnique{w}.rb(2), WindowsUnique{w}.lb(2),WindowsUnique{w}.lt(2)];
	% if is inlier
	if WindowsUnique{w}.votes>=mincCornerVotes
		WindowsUniqueNoOutliers{ww} = WindowsUnique{w}; ww=ww+1;
		colorStr = 'g-';
		% plot windowsUnique
		plot(X, Y, colorStr,'LineWidth',4);
	else
		colorStr = 'r-';
		% plot big red outlier cross in window
		plot(WindowsUnique{w}.windowMidpointX, WindowsUnique{w}.windowMidpointY, 'r+', 'MarkerSize',10);
		% plot windowsUnique
		plot(X, Y, colorStr,'LineWidth',2);
	end
end
