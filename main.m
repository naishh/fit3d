close all;


   

    

% x1 = rand(1,10);
% y1 = rand(1,10);
% 
% vi = convhull(x1,y1);
% polyarea(x1(vi),y1(vi))
% 
% plot(x1,y1,'.')
% axis equal
% hold on
% fill ( x1(vi), y1(vi), 'r','facealpha', 0.5 ); 
% hold off

%for imgNr = 2:5
	%file = sprintf('dataset/FloriandeSet1/img/outd%d.jpg', imgNr)
	file = sprintf('dataset/randombuildings/02_gimped.jpg')
	thresh = 0.05;

	imRGB = imread(file);
	imBW = imadjust(rgb2gray(imRGB));
	figure; imshow(imBW);
	pause;
	

	% gaussian blur
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

	imEdge = im2double(edge(imBW, 'sobel', thresh));
	figure; imshow(imEdge)

	% todo close opening proberen

	xStepSize = 1;
	skylineThresh = 0.9;
	Skyline = getSkyLine(imRGB, imEdge, xStepSize, skylineThresh);
%end
