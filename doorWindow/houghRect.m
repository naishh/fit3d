close all;
% load projected
%load('../project2Normal/Houghlines.mat');
%load('../project2Normal/HoughlinesRot.mat');

load('mats/Houghlines_floriande5447.mat');
load('mats/HoughlinesRot_floriande5447.mat');
plotme = 1;
%cornerInlierThreshold = 0.025
cornerInlierThreshold = 25;
cCornerCornerThreshold = 30;
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold, plotme);
% TODO fix scaleup for scales =! 1
cornerScaleAccu = getCorners(plotme);

figure(3);clf;hold on;

scale = 1;
%i =29 interesting case

for i=1:length(Houghlines)
	i,k,
	plotHoughlineShort(Houghlines(i),1, 'green');
	for k=1:length(Houghlines(i).cCorners)
		if Houghlines(i).cCorners(k).VdirectionUp == 1
			plotcCorner(i, k, Houghlines, HoughlinesRot, 'red');
		end
		if Houghlines(i).cCorners(k).VdirectionUp == 0
			plotcCorner(i, k, Houghlines, HoughlinesRot, 'blue');
		end
	end
	pause;
end


% figure(4);clf;hold on;
% for i=1:length(cCorner)
% 	for j=1:length(cornerScaleAccu(scale).Corners)
% 		% for crossings...
% 		v1 = cCorner(i).crossing; 
% 		v2 = cornerScaleAccu(scale).Corners(j,:)';
% 		d = euclideanDist(v1,v2);
% 		if d<cCornerCornerThreshold;
% 			cCorner(i).harrisEvidence = true;
% 			plotcCorner(cCorner(i), Houghlines,HoughlinesRot, 'green');
% 			plot(v2(1), -v2(2), 'b*');
% 			j
% 		end
% 	end
% end

