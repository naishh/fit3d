function getSkyLineMain()

bMatlabGui = true;
endRange = 6;
SkylinesX = cell(endRange,1);
SkylinesY = cell(endRange,1);
for imgNr = 1:endRange

	% READ IMAGE 
	% starts with outd0 not with outd1
	imgNrFile = imgNr - 1
	file = sprintf('../dataset/FloriandeSet1/img/outd%d.jpg', imgNrFile)

	imRGB = imread(file);
	imBW = imadjust(rgb2gray(imRGB));
	if bMatlabGui
		figure; 
		imshow(imBW);
	end
	

	% GAUSSIAN BLUR
	% todo checken of het wel nut heeft te blurren
	s = fspecial('gaussian',5,5);
	imBW=imfilter(imBW,s);
	if bMatlabGui
		figure; 
		imshow(imBW);
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
		figure; 
		imshow(imEdge);
	end
	

	% todo close opening proberen

	% GET SKYLINE
	xStepSize = 1;
	skylineThresh = 0.9;
	[SkylineX, SkylineY] = getSkyLine(imgNr, imRGB, imEdge, xStepSize, skylineThresh, bMatlabGui);

	%Skylines{imgNr} = struct('SkylineX',SkylineX,'SkylineY', SkylineY, 'SkylineXY', cell(2000,endRange) )
	SkylinesX{imgNr} = SkylineX
	SkylinesY{imgNr} = SkylineY

end
%save ../mats/Skylines Skylines
save ../mats/SkylinesX SkylinesX
save ../mats/SkylinesY SkylinesY
