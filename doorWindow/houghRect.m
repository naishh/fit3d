close all;
% load projected
%load('../project2Normal/Houghlines.mat');
%load('../project2Normal/HoughlinesRot.mat');

load('mats/Houghlines_floriande5447.mat');
load('mats/HoughlinesRot_floriande5447.mat');
plotme = 0;
%cornerInlierThreshold = 0.025

cornerInlierThreshold = 40;
% [crossingAccu, imFeatureIntSect] = getFeatureIntSect(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme);
% cornerScaleAccu = getCorners(plotme);


% TODO scale up oid
im1 = cornerScaleAccu(3).cornerMetricIm;
im2 = imFeatureIntSect;


im2=im2(1:508,1:368);
im2ori = im2;

figure;imshow(im1,[]);
figure;imshow(im2,[]);
h 	= fspecial('gaussian',[20 20])
%im2 = imfilter(im2,h);
%im2 = imfilter(im2,h);
%im2 = imfilter(im2,h);
%im2 = imfilter(im2,h);
%figure;imshow(im2,[]);

figure;imshow(im1,[]);
imCombined = im1+2*im2ori;
imCombined = imfilter(imCombined, h);
figure;imshow(imCombined,[]);




