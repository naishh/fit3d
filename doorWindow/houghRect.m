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
plotme = 0;
[Houghlines, Windows, WindowsIm] = cCornerToWindow(Houghlines,HoughlinesRot,plotme);



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



% 1 middelpunt per cluster kiezen
% van dat cluster adhv nxn filter de gemiddelde height en width berekenen
% running avg maken per pixel?
% ixjx3 matrix (pixelY, pixelX, avg width, avg height,vote count)




% creates X and Y coords for a nxn filter
n=25; h = ((n-1)/2);
X = repmat(-h:h,1,n);
Y = reshape(reshape(X,n,n)',1,n*n);


stepSize = 10;
% generete ranges of x,y position sliding window
for i=h+1:stepSize:size(Windows,1)-h
	i
	for j=h+1:stepSize:size(Windows,2)-h
		foundPoints = 0;
		totHW = [0;0];
		% inside sliding window
		for k=1:n*n
			% window found
			if size(Windows{i+X(k),j+Y(k)},1)==1
				%Windows{i,j}.height
				foundPoints = foundPoints+1;
				totHW = totHW + Windows{i+X(k),j+Y(k)}.hw;
			end
		end

		if foundPoints>=3
			foundPoints
			pause;
			avgHW = totHW / foundPoints
			avgHWhalf = round(avgHW/2)
			plot(i,-j,'*r');
			plotWindow(i,j,avgHWhalf(1), avgHWhalf(2));
		else
			%plot(i,-j,'+k');
		end
	end
end
% opzich is een gauss snel maar dan moet je peaks eruithalen en ben je de breedte en hoogte window kwijt

% n = 21;
% figure;imshow(WindowsIm,[])
% I2=imfilter(WindowsIm, repmat(1,n,n));
% figure;imshow(I2,[])
% 
% I3=imfilter(WindowsIm, fspecial('gaussian',[n n]));
% for i=1:70
% 	I3=imfilter(I3, fspecial('gaussian',[n n]));
% end
% figure;imshow(I3,[]);
