close all;
% load projected
%load('../project2Normal/Houghlines.mat');
%load('../project2Normal/HoughlinesRot.mat');


load('mats/Houghlines_floriande5447.mat');
load('mats/HoughlinesRot_floriande5447.mat');
plotme = 1;
%cornerInlierThreshold = 0.025
cornerInlierThreshold = 20;
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme);
% TODO fix scaleup for scales =! 1
cornerScaleAccu = getCorners(plotme);


cCornerHarrisThreshold = 30; scale = 1;
% loop through Harris features and add evidence for close cCorners
Houghlines = cCornerHarrisEvidence(Houghlines, cornerScaleAccu, scale, cCornerHarrisThreshold);
figure(3);clf;hold on;
Houghlines = cCornerToWindow(Houghlines,HoughlinesRot);



%i =29 interesting case
% plot cCorners nicely
for i=1:length(Houghlines)
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		% type is upper right l shape
		%if cCorner.HdirectionRight == 0 && cCorner.VdirectionUp == 1
		%	% plot vertical line
		%	plotHoughlineShort(Houghlines(i),1, 'black');
		%	% plot horizontally connected lines
		%	plotcCorner(i, k, Houghlines, HoughlinesRot, 'red');
		%elseif cCorner.HdirectionRight == 0 && cCorner.VdirectionUp == 0
		%	% plot vertical line
		%	plotHoughlineShort(Houghlines(i),1, 'black');
		%	% plot horizontally connected lines
		%	plotcCorner(i, k, Houghlines, HoughlinesRot, 'green');
		%end
		plotHoughlineShort(Houghlines(i),1, 'black');
		plotcCorner(i, k, Houghlines, HoughlinesRot, 'green');
	end
end
