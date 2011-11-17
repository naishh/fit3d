%TODO
% out of memory bug at 5 images fixen
% use min and max threshold


% i = rgb2gray(imread('../dataset/datasetSpil/P1120555.JPG'));

function getSkyLineMain()
close all;
bShowImages = 0; 

% % FLORIANDE DATASET:
oDataset.sDatasetName = 'Floriande';
oDataset.sPathToDataset = '../dataset/FloriandeSet1/small/';
oDataset.sBaseFile = 'outd';
oDataset.sPostfix = '.jpg';
oDataset.endRange = 8; %endRange = 5470-5432; 
%oDataset.imStartNr = 5432;
oDataset.imStartNr = 0;
oDataset.edgeMethod = 'sobel';
%oDataset.edgeMethod = 'canny';
oDataset.thresh = 0.05;

% %SPIL DATASET
% oDataset.sDatasetName = 'Spil';
% oDataset.sPathToDataset = '../dataset/datasetSpil/';
% oDataset.sBaseFile = 'P';
% oDataset.sPostfix = '.JPG';
% oDataset.endRange = 1; % use 44 for full
% %oDataset.imStartNr = 1120561;
% %oDataset.imStartNr = 1120555;
% %oDataset.imStartNr = 1120567;
% oDataset.imStartNr = 1120573;
% oDataset.edgeMethod = 'canny';
% oDataset.thresh = 0.7;

if exist('../mats/imsSkyLine.mat') == 2
	disp('loading from ../mats/imsSkyLine.mat..');
	load('../mats/imsSkyLine.mat')
	% no caching possible reading, raw files
else
	disp('loading dataset images from JPGs..');
	% load and save images
	imNrNetto = 1;
	for imNr = 1:oDataset.endRange

		% starts with outd0 not with outd1
		imNrFile = imNr - 1;

		file = [oDataset.sPathToDataset, oDataset.sBaseFile, int2str(oDataset.imStartNr + imNrFile), oDataset.sPostfix]

		% break loop if file doesn't exist
		if exist(file) ~= 2
			disp('file doesnt exist');
			file
			break;
		else
			% READ FILE
			imRGB = imread(file);
			imsSkyLineRGB{imNrNetto}  = imRGB;

			% BLACK AND WHITE
			imBW = imadjust(rgb2gray(imRGB));
			%imsSkyLineBW{imNrNetto}  = imBW;
			

			
			% GAUSSIAN BLUR
			% with spil set not needed
			% floriande 5,5
			s = fspecial('gaussian',5,5);
			imBWblurred=imfilter(imBW,s);
			if bShowImages == 1
				figure; 
				imshow(imBWblurred);
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
			
			%imEdge = im2double(edge(imBWblurred, 'canny', thresh));
			imEdge = edge(imBWblurred, oDataset.edgeMethod, oDataset.thresh);
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
	saveas(fh, ['outputSkyline', oDataset.sDatasetName,'-Im',int2str(imNr),'-thresh',int2str(oDataset.thresh*100),'.jpg'],'jpg');
	% werkt niet hij doet het zwart wit
	%saveas(fh, ['outputSkyline', sDatasetName,'-Im',int2str(imNr),'.eps'], 'eps', 'psc2');

end
disp('saving mats /mats/imsSkyLineBinary.m...')
save('../mats/imsSkyLineBinary.mat', 'imsSkyLineBinary');
