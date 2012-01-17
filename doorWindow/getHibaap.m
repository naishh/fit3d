% HIBAAP - HIstogram BAsed AProach, window detection
% extracts windows based on the pdf of the line endpoints in vertical and horizontal direction
% it covers the seperate treatment of vertical and horizontal lines extracted bij the getHoughlinesVH
close all;

load([startPath,'/doorWindow/mats/Dataset_antwerpen6223_crop1.mat']);
%load([startPath,'/doorWindow/mats/Dataset_antwerpen_6220_nocrop.mat']);

Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot

imshow(Dataset.imEdge);
figure;imshow(Dataset.imOri); hold on;
% TODO put below in getdataset
[Dataset.imHeight, Dataset.imWidth] = size(Dataset.imOri);

[Xv, Yv] = houghlinesToXY(Houghlines);
[Xh, Yh] = houghlinesToXY(HoughlinesRot);

% calc histograms
XvBins = 1:1:max(Xv); XvHist = hist(Xv,XvBins);
YvBins = 1:1:max(Yv); YvHist = hist(Yv,YvBins);
XhBins = 1:1:max(Xh); XhHist = hist(Xh,XhBins);
YhBins = 1:1:max(Yh); YhHist = hist(Yh,YhBins);

% draw histograms (smoothed)
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




XvThresh = 1; 
XvDerivativeThresh = 0.05;
% plot horizontal threshold line
plot([0 Dataset.imWidth],[incrFactor*XvThresh, incrFactor*XvThresh],'k--');
pause;
% find vertical peaks
XvPeaksBinary = XvHistSmooth>=XvThresh;
%XvPeaks = find(XvHistSmooth>=XvThresh);
XvDerivative = diff(XvHistSmooth);
hold on;
for i=1:length(XvPeaksBinary)
	i

	% detect where peaktransform is
	% take area and take maximum peak value

	if XvPeaksBinary(i) == 1
		%if XvHistMaxPeak ==
		%XvHistMaxPeak = XvHist(i)
		% if center of peak found (derivative = 0)

		XvDerivative(i)
		pause;
		if abs(XvDerivative(i)) <= XvDerivativeThresh
			plot([i,i],[0,Dataset.imHeight],'g-');
		else
			plot([i,i],[0,Dataset.imHeight],'r-');
		end
	end
end
err

% search on location of peaks for 
% derivative has to be zero
figure;
plot(-XvHist,'y-');
plot(-XvHistSmooth);
hold on;
pause;
plot(derivative1,'r-');
err


%% find horizontal peaks
%YhThresh = 4; YhPeaks = find(YhHistSmooth>=YhThresh);
%for i=1:length(YhPeaks)
%	plot([0,Dataset.imWidth],[YhPeaks(i),YhPeaks(i)],'k-');
%	hold on;
%end

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


