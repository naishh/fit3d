close all;
clear WindowsMerged
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
fg = figure(3);clf;hold on;
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



% creates X and Y coords for a nxn filter
n=21; h = ((n-1)/2);
X = repmat(-h:h,1,n);
Y = reshape(reshape(X,n,n)',1,n*n);

w = 1;
stepSize = 5;
paramStr = ['slidingWindow_Size_',num2str(n),'_StepSize_',num2str(stepSize)]
% generete ranges of x,y position sliding window
% sliding window starts at h+1
for i=h+1:stepSize:size(Windows,1)-h
	i
	for j=h+1:stepSize:size(Windows,2)-h
		nrWindows = 0;
		totHW = [0;0];
		% inside sliding window X(k) and Y(k) have coords
		for k=1:n*n
			% window found
			if size(Windows{i+X(k),j+Y(k)},1)==1
				%Windows{i,j}.height
				nrWindows = nrWindows+1;
				% sum height widths of windows
				totHW = totHW + Windows{i+X(k),j+Y(k)}.hw;
			end
		end

		% if found a window in the sliding window
		if nrWindows>=1
			WindowsMerged{w}.nrWindows = nrWindows;
			WindowsMerged{w}.avgHWHalf = round((totHW/nrWindows)/2);
			WindowsMerged{w}.x = i;
			WindowsMerged{w}.y = j;
			% update average height width of window
			avgHW = totHW / nrWindows;
			w = w + 1;
		end
	end
end

pause;

% determine max nr of windows
nrWindowsMax = 0;
for w=1:length(WindowsMerged)
	if WindowsMerged{w}.nrWindows > nrWindowsMax
		nrWindowsMax = WindowsMerged{w}.nrWindows;
	end
end

% plot windows 
for w=1:length(WindowsMerged)
	w
	% amound of black = 1-white, take minimum 0.2 else you dont see it
	grayScale = max(0.2,1-(WindowsMerged{w}.nrWindows/nrWindowsMax));
	grayScale = [grayScale, grayScale, grayScale];
	if WindowsMerged{w}.nrWindows>=1
		plotWindowColored(WindowsMerged{w}.x,WindowsMerged{w}.y,WindowsMerged{w}.avgHWHalf(1),WindowsMerged{w}.avgHWHalf(2),grayScale);
	end
end

reply = input('Save result as images? y/n [n]: ', 's');
if isempty(reply)
	reply = 'n';
end
if reply=='y'
	disp('saving images..');
	% save images
	saveas(fg,['resultsWindow/doorWindow_',paramStr],'png');
	disp('done');
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


% 1 middelpunt per cluster kiezen
% van dat cluster adhv nxn filter de gemiddelde height en width berekenen
% running avg maken per pixel?
% ixjx3 matrix (pixelY, pixelX, avg width, avg height,vote count)
