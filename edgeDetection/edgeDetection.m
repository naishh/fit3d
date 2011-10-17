close all;

bMatlabGui = true; 
%endRange = 5470-5432; 
endRange = 8;
imStartNr = 5432;

imNr = 1

	% READ IMAGE 
	% starts with outd0 not with outd1
	imNrFile = imNr - 1
	%file = sprintf('../dataset/FloriandeSet1/small/outd%d.jpg', imNrFile)
	file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imStartNr + imNrFile)

	% imRGB = imread(file);
	% imBW = imadjust(rgb2gray(imRGB));
	% if bMatlabGui
	% 	figure; 
	% 	imshow(imBW);
	% end
	% 

	% % GAUSSIAN BLUR
	% % todo checken of het wel nut heeft te blurren
	% s = fspecial('gaussian',5,5);
	% imBW=imfilter(imBW,s);
	% if bMatlabGui
	% 	figure; 
	% 	imshow(imBW);
	% end

	%threshtest

	% TODO 2 thresholds meegeven aan canny

	for thresh=0.05:0.05:1
		imEdge = im2double(edge(imBW, 'sobel', thresh));
		%figure(round(thresh*100));
		imshow(imEdge)
		pause;
	end

	% EDGE DETECTION
	thresh = 0.05;
	imEdge = im2double(edge(imBW, 'sobel', thresh));
	if bMatlabGui
		%figure; 
		%imshow(imEdge);
	end
	
