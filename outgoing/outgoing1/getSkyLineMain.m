function [SkylineX, SkylineY] = getSkyLineMain()
close all;
%for imgNr = 2:5

	% READ IMAGE 
	%file = sprintf('dataset/randombuildings/02_gimped.jpg')
	%file = sprintf('dataset/FloriandeSet1/img/outd%d.jpg', imgNr)
	file = sprintf('dataset/FloriandeSet1/img/outd0_highcontrast.jpg')

	imRGB = imread(file);
	imBW = imadjust(rgb2gray(imRGB));
	figure; imshow(imBW);
	pause;
	

	% GAUSSIAN BLUR
	% todo checken of het wel nut heef te blurren
	s = fspecial('gaussian',5,5);
	imBW=imfilter(imBW,s);
	figure; imshow(imBW);
	pause;

	%threshtest
	% for thresh=0.05:0.05:1
	% 	imEdge = im2double(edge(imBW, 'sobel', thresh));
	% 	figure(round(thresh*100));
	% 	imshow(imEdge)
	% 	pause;
	% end

	% EDGE DETECTION
	thresh = 0.05;
	imEdge = im2double(edge(imBW, 'sobel', thresh));
	figure; imshow(imEdge)

	% todo close opening proberen

	% GET SKYLINE
	xStepSize = 1;
	skylineThresh = 0.9;
	[SkylineX, SkylineY] = getSkyLine(imRGB, imEdge, xStepSize, skylineThresh);
%end
