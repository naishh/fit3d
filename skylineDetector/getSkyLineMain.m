%TODO
% out of memory bug at 5 images fixen
% use min and max threshold


% i = rgb2gray(imread('../dataset/datasetSpil/P1120555.JPG'));

function getSkyLineMain()
close all;
bShowImages = 0; 

% % FLORIANDE DATASET:
% sPathToDataset = '../dataset/FloriandeSet1/small/'
% sBaseFile = 'outd'
% sPostfix = 'jpg'
% 
% %endRange = 5470-5432; 
% endRange = 8;
% imStartNr = 5432;

%SPIL DATASET
sDatasetName = 'Spil';
sPathToDataset = '../dataset/datasetSpil/';
sBaseFile = 'P';
%sPostfix = '_small.JPG';
sPostfix = '.JPG';

%endRange = 44;
endRange = 1;
%imStartNr = 1120561;
%imStartNr = 1120555;
%imStartNr = 1120567;
imStartNr = 1120573;



if exist('../mats/imsSkyLine.mat') == 2
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

		file = [sPathToDataset, sBaseFile, int2str(imStartNr + imNrFile), sPostfix]

		% break loop if file doesn't exist
		if exist(file) ~= 2
			break;
		else
			% READ FILE
			imRGB = imread(file);
			imsSkyLineRGB{imNrNetto}  = imRGB;

			% BLACK AND WHITE
			imBW = imadjust(rgb2gray(imRGB));
			%imsSkyLineBW{imNrNetto}  = imBW;
			

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
			%thresh = 0.10;
			thresh = 0.7;
			%imEdge = im2double(edge(imBWblurred, 'canny', thresh));
			imEdge = edge(imBWblurred, 'canny', thresh);
			if bShowImages
				figure; 
				imshow(imEdge);
			end

			imsSkyLineEdge{imNrNetto}  = imEdge;

			imNrNetto = imNrNetto + 1;
		end
		
		% save images
	end
	disp('saving into imsSkyLine.mat...')
	%save('../mats/imsSkyLine.mat','imsSkyLineRGB','imsSkyLineBW','imsSkyLineEdge')
	save('../mats/imsSkyLine.mat','imsSkyLineRGB','imsSkyLineEdge')
	disp('done')
end



for imNr = 1:length(imsSkyLineRGB)
	
	imRGB  = imsSkyLineRGB{imNr};
	%imBW  = imsSkyLineBW{imNr};
	imEdge = imsSkyLineEdge{imNr};

	% TODO close opening proberen

	% GET SKYLINE
	xStepSize = 1;
	disp('starting skyline detection..');
	[SkylineX, SkylineY, imMarked, imBinary] = getSkyLine(imNr, imRGB, imEdge, xStepSize);
	disp('done');

	%store per image the result
	imsSkyLineBinary{imNr} = imBinary

	%imSkylineDrawed = drawSkyline(imBW, imBinary)
	%figure;
	%imshow(imSkylineDrawed);

	%figure;
	%imshow(imMarked);
	disp('saving..');
	disp(int2str(imNr));
	fh=figure(1);
	imshow(imMarked);
	saveas(fh, ['outputSkyline', sDatasetName,'-Im',int2str(imNr),'-thresh',int2str(thresh*100),'.jpg'],'jpg');
	% werkt niet hij doet het zwart wit
	%saveas(fh, ['outputSkyline', sDatasetName,'-Im',int2str(imNr),'.eps'], 'eps', 'psc2');

end
disp('saving mats /mats/imsSkyLineBinary.m...')
save('../mats/imsSkyLineBinary.mat', 'imsSkyLineBinary');
