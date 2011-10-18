%TODO
% make file reader who reads in memory
% use min and max threshold

% i = rgb2gray(imread('../dataset/datasetSpil/P1120555.JPG'));

function getSkyLineMain()
close all;
bShowImages = 1; 

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
endRange = 1;
imStartNr = 1120555;



% imsRGB is var in workspace
% TODO imsSkyLineRGB staat niet in workspace, howcome?
if exist('imsSkyLineBW') == 1 && exist('imsSkyLineEdge') == 1
	disp('using ims from workspace..');
% if imsRGB.mat is present
elseif exist('../mats/imsSkyLine.mat') == 2
	disp('loading from ../mats/imsSkyLine.mat..');
	load('../mats/imsSkyLine.mat')
	% no caching possible reading, raw files
else
	disp('loading dataset images from JPGs..');
	% load and save images
	imNrNetto = 1;
	for imNr = 1:endRange

		% starts with outd0 not with outd1
		imNrFile = imNr - 1;

		file = [sPathToDataset, sBaseFile, int2str(imStartNr + imNrFile), '.', sExtention]

		% break loop if file doesn't exist
		if exist(file) ~= 2
			break;
		else
			% READ FILE
			imRGB = imread(file);
			%imsSkyLineRGB{imNrNetto}  = imRGB;

			% BLACK AND WHITE
			imBW = imadjust(rgb2gray(imRGB));
			imsSkyLineBW{imNrNetto}  = imBW;
			

			% % GAUSSIAN BLUR
			% % floriande 5,5
			% s = fspecial('gaussian',20,20);
			% imBWblurred=imfilter(imBW,s);
			% if bShowImages == 1
			% 	figure; 
			% 	imshow(imBWblurred);
			% end
			imBWblurred = imBW;

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
			%floriande 0.05, sobel
			%thresh = 0.05;
			thresh = 0.10;
			imEdge = im2double(edge(imBWblurred, 'canny', thresh));
			% if bShowImages
			% 	figure; 
			% 	imshow(imEdge);
			% end

			imsSkyLineEdge{imNrNetto}  = imEdge;

			imNrNetto = imNrNetto + 1;
		end
		
		% save images
	end
	disp('saving into imsSkyLine.mat...')
	save('../mats/imsSkyLine.mat','imsSkyLineBW','imsSkyLineEdge')
	global imsSkyLineBW;
	global imsSkyLineEdge;
	disp('done')
end


SkylinesX = cell(endRange,1);
SkylinesY = cell(endRange,1);

for imNr = 1:length(imsSkyLineBW)
	
	%imRGB  = imsSkyLineRGB{imNr};
	imBW  = imsSkyLineBW{imNr};
	imEdge = imsSkyLineEdge{imNr};

	% TODO close opening proberen

	% GET SKYLINE
	xStepSize = 1;
	skylineThresh = 0.9;
	disp('starting skyline detection..');
	[SkylineX, SkylineY, imMarked, imBinary] = getSkyLine(imNr, imBW, imEdge, xStepSize, skylineThresh, bShowImages);
	disp('done');

	%store per image the result
	imsSkyLineBinary{imNr} = imBinary

	SkylinesX{imNr} = SkylineX
	SkylinesY{imNr} = SkylineY
	
	imSkylineDrawed = drawSkyline(imBW, imBinary)
	figure;
	imshow(imSkylineDrawed);

end
disp('saving mats..')
% save('../mats/SkylinesX.mat', 'SkylinesX');
% save('../mats/SkylinesY.mat', 'SkylinesY');
save('../mats/imsSkyLineBinary.mat', 'imsSkyLineBinary');
global imsSkyLineBinary;

