%EDGE DETECTION METHODS 
close all;


file = sprintf('../dataset/FloriandeSet1/small/outd3_crop1.jpg', imNrFile)

imRGB = imread(file);
imBW = imadjust(rgb2gray(imRGB));

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

%for thresh=0.05:0.05:1
%	imEdge = im2double(edge(imBW, 'sobel', thresh));
%	%figure(round(thresh*100));
%	imshow(imEdge)
%	pause;
%end

% EDGE DETECTION
for thresh=0.4:0.05:0.9
	imEdge = im2double(edge(imBW, 'canny', thresh));
	figure(round(thresh*100));
	imshow(imEdge);
end

%
thresh = 0.15
imEdge = im2double(edge(imBW, 'sobel', thresh));
figure(round(thresh*100));
imshow(imEdge);
