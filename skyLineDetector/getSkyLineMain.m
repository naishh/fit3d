%TODO
% make file reader who reads in memory
% use min and max threshold

function getSkyLineMain()
close all;

bMatlabGui = true; 


% % FLORIANDE DATASET:
% sPathToDataset = '../dataset/FloriandeSet1/small/'
% sBaseFile = 'outd'
% sExtention = 'jpg'
% 
% %endRange = 5470-5432; 
% endRange = 8;
% imStartNr = 5432;

%SPIL DATASET
sPathToDataset = '../dataset/datasetSpil/';
sBaseFile = 'P';
sExtention = 'JPG';

%endRange = 44;
endRange = 2;
imStartNr = 1120555;
%allImages = {'P1120555.JPG', 'P1120556.JPG', 'P1120557.JPG', 'P1120558.JPG', 'P1120559.JPG', 'P1120560.JPG', 'P1120561.JPG', 'P1120562.JPG', 'P1120563.JPG', 'P1120564.JPG', 'P1120565.JPG', 'P1120566.JPG', 'P1120567.JPG', 'P1120568.JPG', 'P1120569.JPG', 'P1120570.JPG', 'P1120571.JPG', 'P1120572.JPG', 'P1120573.JPG', 'P1120574.JPG', 'P1120575.JPG', 'P1120576.JPG', 'P1120577.JPG', 'P1120578.JPG', 'P1120579.JPG', 'P1120580.JPG', 'P1120581.JPG', 'P1120582.JPG', 'P1120583.JPG', 'P1120584.JPG', 'P1120585.JPG', 'P1120586.JPG', 'P1120587.JPG', 'P1120588.JPG', 'P1120589.JPG', 'P1120590.JPG', 'P1120591.JPG', 'P1120596.JPG', 'P1120597.JPG', 'P1120599.JPG'} 

SkylinesX = cell(endRange,1);
SkylinesY = cell(endRange,1);


% imsRGB is var in workspace
if exist('imsRGB') == 1
	disp('using imsRGB from workspace..');
% if imsRGB.mat is present
elseif exist('imsRGB.mat') == 2
	disp('loading imsRGB from imsRGB.mat..');
	load('imsRGB.mat')
	% no caching possible reading, raw files
else
	disp('loading dataset images from JPGs..');
	% load and save images
	imNrNetto = 1;
	for imNr = 1:endRange

		% READ IMAGE 
		% starts with outd0 not with outd1
		imNrFile = imNr - 1

		%file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imStartNr + imNrFile)
		file = [sPathToDataset, sBaseFile, int2str(imStartNr + imNrFile), '.', sExtention]

		% break loop if file doesn't exist
		if exist(file) ~= 2
			break;
		else
			imsRGB{imNrNetto}  = imread(file);
			imNrNetto = imNrNetto + 1;
		end
		
		% save images
	end
	disp('saving into imsRGB.mat...')
	save('imsRGB.mat','imsRGB')
end


for imNr = 1:length(imsRGB)
	
	imRGB = imsRGB{imNr};

	% BLACK AND WHITE
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

	% % threshtest
	% %for thresh=0.00:0.05:1
	% for thresh=0.00:0.01:0.1
	%    thresh
	%    imEdge = im2double(edge(imBW, 'sobel', thresh));
	%    %figure(round(thresh*100)+1);
	%    figure;
	% 
	%    imshow(imEdge)
	%    pause;
	% end

	
	% EDGE DETECTION
	%floriande 0.05
	%thresh = 0.05;
	thresh = 0.02;
	imEdge = im2double(edge(imBW, 'sobel', thresh));
	if bMatlabGui
		figure; 
		imshow(imEdge);
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
save('../mats/SkylinesX.mat', 'SkylinesX');
save('../mats/SkylinesY.mat', 'SkylinesY');
save('../mats/imBWSkylines.mat', 'imBWSkylines');
