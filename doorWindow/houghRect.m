close all;
% load projected
%load('../project2Normal/Houghlines.mat');
%load('../project2Normal/HoughlinesRot.mat');

load('mats/Houghlines_floriande5447.mat');
load('mats/HoughlinesRot_floriande5447.mat');
plotme = 1;
%cornerInlierThreshold = 0.025
cornerInlierThreshold = 40
%crossingAccu = getFeatureIntSect(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme)

plotme = 0;
cornerScaleAccu = getCorners(plotme);


% loop through found corners
% check how many crossings are within certain threshold


