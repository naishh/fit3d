% HIBAAP - HIstogram BAsed AProach, window detection
% extracts windows based on the pdf of the houghline endpoints in vertical and horizontal direction
% it covers the seperate treatment of vertical and horizontal lines extracted bij the getHoughlinesVH
% it fuses the result of the cCorner aproach
close all;
tic;

%load([startPath,'/doorWindow/mats/Dataset_antwerpen_6223_crop1.mat']);
load([startPath,'/doorWindow/mats/Dataset_antwerpen_6220_nocrop.mat']);
%Dataset_antwerpen_6220_nocrop.mat

%figure;imshow(Dataset.imOriDimmed); hold on;
figure;imshow(Dataset.imOri); hold on;

% get coords of endpoints of houghlines
[Xv, Yv] = houghlinesToXY(Dataset.Houghlines);
[Xh, Yh] = houghlinesToXY(Dataset.HoughlinesRot);

% calc histograms
XvBins = 1:1:Dataset.imWidth; XvHist = hist(Xv,XvBins);
YhBins = 1:1:Dataset.imHeight; YhHist = hist(Yh,YhBins);
% 'unusable' histograms
% YvBins = 1:1:Dataset.imHeight; YvHist = hist(Yv,YvBins);
% XhBins = 1:1:Dataset.imWidth; XhHist = hist(Xh,XhBins);

% smooth histograms 
incrFactor = 20; % TODO make perncent of avg image width height
XvHistSmooth = smoothNtimes(XvHist,6);
YhHistSmooth = smoothNtimes(YhHist,6);

% plot histograms
plot(incrFactor*XvHist,'y-');
plot(incrFactor*YhHist, YhBins, 'y-');

% plot histograms smoothed
plot(incrFactor*XvHistSmooth,'r-');
plot(incrFactor*YhHistSmooth, YhBins, 'r-');

% set histogram thresholds
XvThresh = 0.5; YhThresh = 0.5; 
% plot horizontal threshold line
plot([0 Dataset.imWidth],[incrFactor*XvThresh, incrFactor*XvThresh],'k--','LineWidth',2); hold on;
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

% new figure
pause; figure;imshow(Dataset.imOriDimmed); hold on;

% get cCorners
maxWindowSize = 200;
cornerInlierThreshold = 0.2
% TODO transform to cCorner
Houghlines = getcCorner(Dataset.Houghlines,Dataset.HoughlinesRot,cornerInlierThreshold,maxWindowSize);
disp('plotting cCorner windows'); 
%plotcCorners(Dataset.Houghlines, Dataset.HoughlinesRot)

% loop through cCorners and draw window @ 4 nearby crossings from kwadrants
w = 1;
for i=1:length(Houghlines)
	i
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		plotcCorner(cCorner,'window');
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
		if size(EpcLeftTop,1) + size(EpcRightTop,1) + size(EpcRightBottom,1) + size(EpcLeftBottom,1) >= 4
			% get closest crossing from crossings quadrant selection
			Window{w}.lt 	= getClosestPointInArray([winX,winY],EpcLeftTop);
			Window{w}.rt 	= getClosestPointInArray([winX,winY],EpcRightTop);
			Window{w}.rb 	= getClosestPointInArray([winX,winY],EpcRightBottom);
			Window{w}.lb 	= getClosestPointInArray([winX,winY],EpcLeftBottom);
			Window{w}.width = Window{w}.rt(1) - Window{w}.lt(1);
			Window{w}.height= Window{w}.rb(2) - Window{w}.rt(2);
			
			% collect coords for window
			X = [Window{w}.lt(1), Window{w}.rt(1), Window{w}.rb(1), Window{w}.lb(1),Window{w}.lt(1)];
			Y = [Window{w}.lt(2), Window{w}.rt(2), Window{w}.rb(2), Window{w}.lb(2),Window{w}.lt(2)];
			% plot window
			plot(X, Y, 'g-','LineWidth',4);

			% plot cross in middle again to ensure its on the foreground
			plot(winX, winY, 'b+');

			w = w + 1;
		else
			disp('no nearby crossings found.. i,k');
			i,k
		end
	end
end

toc
