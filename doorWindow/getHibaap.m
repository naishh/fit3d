% HIBAAP - HIstogram BAsed AProach, window detection
% extracts windows based on the pdf of the line endpoints in vertical and horizontal direction
% it covers the seperate treatment of vertical and horizontal lines extracted bij the getHoughlinesVH
close all;

load([startPath,'/doorWindow/mats/Dataset_antwerpen6223_crop1.mat']);
%load([startPath,'/doorWindow/mats/Dataset_antwerpen_6220_nocrop.mat']);

Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot;

imshow(Dataset.imEdge);
figure;imshow(Dataset.imOri); hold on;
% TODO put below in getdataset
[Dataset.imHeight, Dataset.imWidth] = size(Dataset.imOri);

[Xv, Yv] = houghlinesToXY(Houghlines);
[Xh, Yh] = houghlinesToXY(HoughlinesRot);

% calc histograms
XvBins = 1:1:Dataset.imWidth; XvHist = hist(Xv,XvBins);
YvBins = 1:1:Dataset.imHeight; YvHist = hist(Yv,YvBins);
XhBins = 1:1:Dataset.imWidth; XhHist = hist(Xh,XhBins);
YhBins = 1:1:Dataset.imHeight; YhHist = hist(Yh,YhBins);

% draw histograms (smoothed)
incrFactor = 20;
XvHistSmooth = smoothNtimes(XvHist,6)
YhHistSmooth = smoothNtimes(YhHist,6);
% plot histograms
plot(incrFactor*XvHist,'y-');
plot(incrFactor*YvHist, YhBins, 'y-');
% plot histograms smoothed
plot(incrFactor*XvHistSmooth,'r-');
plot(incrFactor*YhHistSmooth, YhBins, 'r-');

% 'unusable' histograms
%YvHistSmooth = smooth(YvHist);
%plot(incrFactor*YvHistSmooth, YvBins, 'b-')
%XhHistSmooth = smooth(XhHist);
%plot(incrFactor*XhHistSmooth,'b-')




XvThresh = 0.5; 
% plot horizontal threshold line
plot([0 Dataset.imWidth],[incrFactor*XvThresh, incrFactor*XvThresh],'k--'); hold on;
% find vertical peaks
% TODO 
% transform below to function

% input
% XvHistSmooth
% XvThresh
% Dataset


plotme = 1;
XvHistMaxPeaks = getHistMaxPeaks(Dataset, XvHistSmooth, XvThresh, plotme);


% % finds and plot intersections of vertical and horizontal lines
% EdgePeakCrossings = [];
% for i=1:length(XvPeaks)
% 	for j=1:length(YhPeaks)
% 		%plot([XvPeaks(i),XvPeaks(i)],[0,h],'b-');
% 		%plot([0,w],[YhPeaks(j),YhPeaks(j)],'k-');
% 		[crossing,d,l1,l2] = getLineCrossing([XvPeaks(i),0]',[XvPeaks(i),h]',[0,YhPeaks(j)]',[w,YhPeaks(j)]');
% 		%plot(crossing(1), crossing(2), '+g');
% 		EdgePeakCrossings = [EdgePeakCrossings;crossing'];
% 	end
% end






maxWindowSize = 200;
cornerInlierThreshold = 0.2
disp('getting cCorners..')
Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold,maxWindowSize);
disp('plotting complete windows'); 
%plotcCorners(Houghlines, HoughlinesRot)



tic
w = 1;
% loop through cCorners
% TODO CHANGE 10 TO 1!!
for i=10:length(Houghlines)
	i
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		%plotcCorner(cCorner,'window');
		winX = cCorner.windowMidpointX;
		winY = cCorner.windowMidpointY;

		% get edge peak crossings kwadrants with the midpoint of window as origin
		EpcLeft 		= EdgePeakCrossings(EdgePeakCrossings(:,1)<=winX,:);
		EpcLeftTop 		= EpcLeft(EpcLeft(:,2)<=winY,:);
		EpcLeftBottom 	= EpcLeft(EpcLeft(:,2)>winY,:);
		EpcRight 		= EdgePeakCrossings(EdgePeakCrossings(:,1)>winX, :);
		EpcRightTop 	= EpcRight(EpcRight(:,2)<=winY, :);
		EpcRightBottom 	= EpcRight(EpcRight(:,2)>winY, :);

		Window{w}.lt 	= getClosestPointInArray([winX,winY],EpcLeftTop);
		Window{w}.rt 	= getClosestPointInArray([winX,winY],EpcRightTop);
		Window{w}.rb 	= getClosestPointInArray([winX,winY],EpcRightBottom);
		Window{w}.lb 	= getClosestPointInArray([winX,winY],EpcLeftBottom);
		Window{w}.width = Window{w}.rt - Window{w}.lt;
		Window{w}.height= Window{w}.rb - Window{w}.rt;

		if Window{w}.width > 10
			colorStr = 'g-';
		else
			colorStr = 'r-';
		end
		
		X = [Window{w}.lt(1), Window{w}.rt(1), Window{w}.rb(1), Window{w}.lb(1),Window{w}.lt(1)];
		Y = [Window{w}.lt(2), Window{w}.rt(2), Window{w}.rb(2), Window{w}.lb(2),Window{w}.lt(2)];
		plot(X, Y, colorStr);
		% clustering
		% window with minimum width?
		w = w + 1;
	end
end
toc


