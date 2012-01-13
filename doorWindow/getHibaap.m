% HIBAAP - HIstogram BAsed AProach, window detection
% extracts windows based on the pdf of the line endpoints in vertical and horizontal direction
% it covers the seperate treatment of vertical and horizontal lines extracted bij the getHoughlinesVH
close all;

load([startPath,'/doorWindow/mats/Dataset_antwerpen6223_crop1.mat']);
Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot

imshow(Dataset.imOri); hold on;

% get all X values of all endpoints of vertical houghlines 
Xv = [];
Yv = [];
for i=1:length(Houghlines)
	Xv = [Xv, Houghlines(i).point1(1),Houghlines(i).point2(1)];
	Yv = [Yv, Houghlines(i).point1(2),Houghlines(i).point2(2)];
end



XvBins = 1:1:max(Xv);
XvHist = hist(Xv,XvBins)
YvBins = 1:1:max(Yv);
YvHist = hist(Yv,YvBins)


plot(XvHist)
figure;
plot(zeros(length(YvHist)),YvHist)




