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


XvThresh = 4
XvPeaks = find(XvHist>=XvThresh)

h=size(Dataset.imOri,1);
for i=1:length(XvPeaks)
	XvPeaks(i)
	plot([XvPeaks(i),XvPeaks(i)],[0,h],'b-');
	hold on;
end


YhThresh = 4
YhPeaks = find(YhHist>=YhThresh)

w=size(Dataset.imOri,2);
for i=1:length(YhPeaks)
	YhPeaks(i)
	plot([0,w],[YhPeaks(i),YhPeaks(i)],'k-');
	hold on;
end

