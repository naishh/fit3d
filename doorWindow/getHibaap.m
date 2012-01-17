% HIBAAP - HIstogram BAsed AProach, window detection
% extracts windows based on the pdf of the line endpoints in vertical and horizontal direction
% it covers the seperate treatment of vertical and horizontal lines extracted bij the getHoughlinesVH
close all;

load([startPath,'/doorWindow/mats/Dataset_antwerpen6223_crop1.mat']);
%load([startPath,'/doorWindow/mats/Dataset_antwerpen_6220_nocrop.mat']);

Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot

imshow(Dataset.imEdge);
figure;imshow(Dataset.imOri); hold on;

[Xv, Yv] = houghlinesToXY(Houghlines);
[Xh, Yh] = houghlinesToXY(HoughlinesRot);

% calc histograms
XvBins = 1:1:max(Xv); XvHist = hist(Xv,XvBins);
YvBins = 1:1:max(Yv); YvHist = hist(Yv,YvBins);
XhBins = 1:1:max(Xh); XhHist = hist(Xh,XhBins);
YhBins = 1:1:max(Yh); YhHist = hist(Yh,YhBins);

% draw histograms smoothed
incrFactor = 20;
XvHistSmooth = smooth(XvHist);
plot(incrFactor*XvHistSmooth,'y-');
XvHistSmooth = smooth(smooth(smooth(smooth(XvHist))));
plot(incrFactor*XvHistSmooth,'r-');
%YvHistSmooth = smooth(YvHist);
%plot(incrFactor*YvHistSmooth, YvBins, 'b-')
%XhHistSmooth = smooth(XhHist);
%plot(incrFactor*XhHistSmooth,'b-')
YhHistSmooth = smooth(YhHist);
plot(incrFactor*YhHistSmooth, YhBins, 'r-');


% find vertical peaks
XvThresh = 2; XvPeaks = find(XvHist>=XvThresh);
h=size(Dataset.imOri,1);
for i=1:length(XvPeaks)
	%plot([XvPeaks(i),XvPeaks(i)],[0,h],'b-');
	hold on;
end


% find horizontal peaks
YhThresh = 4; YhPeaks = find(YhHist>=YhThresh);
w=size(Dataset.imOri,2);
for i=1:length(YhPeaks)
	%plot([0,w],[YhPeaks(i),YhPeaks(i)],'k-');
	hold on;
end

EdgePeakCrossings = [];

% finds and plot intersections of vertical and horizontal lines
for i=1:length(XvPeaks)
	for j=1:length(YhPeaks)
		%plot([XvPeaks(i),XvPeaks(i)],[0,h],'b-');
		%plot([0,w],[YhPeaks(j),YhPeaks(j)],'k-');
		[crossing,d,l1,l2] = getLineCrossing([XvPeaks(i),0]',[XvPeaks(i),h]',[0,YhPeaks(j)]',[w,YhPeaks(j)]');
		%plot(crossing(1), crossing(2), '+g');
		EdgePeakCrossings = [EdgePeakCrossings;crossing'];
	end
end



maxWindowSize = 200;
cornerInlierThreshold = 0.2
disp('getting cCorners..')
Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold,maxWindowSize);
disp('plotting complete windows'); 
%plotcCorners(Houghlines, HoughlinesRot)


% loop through cCorners
% TODO CHANGE 10 TO 1!!
for i=10:length(Houghlines)
	i
	for k=1:length(Houghlines(i).cCorners)
		k
		
		cCorner = Houghlines(i).cCorners(k);
		plotcCorner(cCorner,'window');
		winX = cCorner.windowMidpointX
		winY = cCorner.windowMidpointY

		% get edge peak crossings kwadrants with the midpoint of window as origin
		EpcLeft 		= EdgePeakCrossings(EdgePeakCrossings(:,1)<=winX,:)
		EpcLeftTop 		= EpcLeft(EpcLeft(:,2)<=winY,:)
		EpcLeftBottom 	= EpcLeft(EpcLeft(:,2)>winY,:)
		EpcRight 		= EdgePeakCrossings(EdgePeakCrossings(:,1)>winX, :)
		EpcRightTop 	= EpcRight(EpcRight(:,2)<=winY, :)
		EpcRightBottom 	= EpcRight(EpcRight(:,2)>winY, :)

		closestPoint = getClosestPointInArray([winX,winY],EpcLeftTop)
		plot(closestPoint(1), closestPoint(2),'k+');
		closestPoint = getClosestPointInArray([winX,winY],EpcRightTop)
		plot(closestPoint(1), closestPoint(2),'k+');
		closestPoint = getClosestPointInArray([winX,winY],EpcRightBottom)
		plot(closestPoint(1), closestPoint(2),'k+');
		closestPoint = getClosestPointInArray([winX,winY],EpcLeftBottom)
		plot(closestPoint(1), closestPoint(2),'k+');
		% draw window from closestPoints
		% clustering
		% window with minimum width?

		pause;
		% accumulate crossings above
		% search in 4 kwadrants for closest crossing
	end
end

