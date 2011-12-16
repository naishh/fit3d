close all;
% load projected
%load('../project2Normal/Houghlines.mat');
%load('../project2Normal/HoughlinesRot.mat');

load('mats/Houghlines_floriande5447.mat');
load('mats/HoughlinesRot_floriande5447.mat');
plotme = 0;
%cornerInlierThreshold = 0.025

cornerInlierThreshold = 40;
[crossingAccu, imFeatureIntSect] = getFeatureIntSect(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme);
cornerScaleAccu = getCorners(plotme);


figure;

im1 = cornerScaleAccu(1).cornerMetricIm;
im2 = imFeatureIntSect;
im2=im2(1:508,1:368);
size(im1)
size(im2)

figure;imshow(im1,[]);
figure;imshow(im2,[]);
figure;imshow(im1+im2,[]);

% TODO image im1 goed gespiegeld krijgen


