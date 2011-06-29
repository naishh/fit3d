function getSkyLineMain()
close all;

bMatlabGui = true; endRange = 5470-5432; imStartNr = 5432;

SkylinesX = cell(endRange,1);
SkylinesY = cell(endRange,1);

for imNr = 1:endRange

	% READ IMAGE 
	% starts with outd0 not with outd1
	imNrFile = imNr - 1
	%file = sprintf('../dataset/FloriandeSet1/small/outd%d.jpg', imNrFile)
	file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imStartNr + imNrFile)

	imRGB = imread(file);
	imBW = imadjust(rgb2gray(imRGB));
	if bMatlabGui
		%figure; 
		%imshow(imBW);
	end
	

	% GAUSSIAN BLUR
	% todo checken of het wel nut heeft te blurren
	s = fspecial('gaussian',5,5);
	imBW=imfilter(imBW,s);
	if bMatlabGui
		%figure; 
		%imshow(imBW);
	end

	%threshtest
	% for thresh=0.05:0.05:1
	% 	imEdge = im2double(edge(imBW, 'sobel', thresh));
	% 	%figure(round(thresh*100));
	% 	imshow(imEdge)
	% 	pause;
	% end

	% EDGE DETECTION
	thresh = 0.05;
	imEdge = im2double(edge(imBW, 'sobel', thresh));
	if bMatlabGui
		%figure; 
		%imshow(imEdge);
	end
	

	% todo close opening proberen

	% GET SKYLINE
	xStepSize = 1;
	skylineThresh = 0.9;
	[SkylineX, SkylineY, imBWSkyline] = getSkyLine(imNr, imRGB, imEdge, xStepSize, skylineThresh, bMatlabGui);

	%store per image the result
	imBWSkylines{imNr} = imBWSkyline

	SkylinesX{imNr} = SkylineX
	SkylinesY{imNr} = SkylineY

end
disp('saving mats..')
save('../mats/SkylinesX.mat', SkylinesX);
save('../mats/SkylinesY.mat', SkylinesY);
save('../mats/imBWSkylines.mat', imBWSkylines);
