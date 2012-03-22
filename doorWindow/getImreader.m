fprintf('\nStarting ImReader...');

% read file
ImReader.imOri 					= imread(ImReader.file);
ImReader.imOriDimmed 			= 0.8*ImReader.imOri;

% crop img
if isfield(Dataset, 'cropArea')
	r = Dataset.cropArea
	ImReader.imCropped = ImReader.imOri(r(1):r(3),r(2):r(4),:);
	%imshow(ImReader.imCropped);
else
	ImReader.imCropped = ImReader.imOri;
end

ImReader.imHeight 					= size(ImReader.imCropped, 1);
ImReader.imWidth					= size(ImReader.imCropped, 2);
% transform color


ImReader.imBlurred = ImReader.imCropped
if isfield(Dataset, 'ImReaderParam')
	if isfield(Dataset.ImReaderParam, 'blurIm')
		if Dataset.ImReaderParam.blurIm
			h=fspecial('Gaussian',10,10);
			ImReader.imBlurred = imfilter(ImReader.imBlurred, h);
			figure; imshow(ImReader.imCropped);
			figure; imshow(ImReader.imBlurred);
		end
	end
end

ImReader.imColorModelTransform   = getColorModelTransform(ImReader.imBlurred, Dataset);

% perform edge detection
ImReader.imEdge = getEdge(ImReader, Dataset.EdgeDetectorParam);
if plotmeImEdge
	figure;imshow(ImReader.imEdge)
end

% save to disk var
saveStr = [startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_ImReader.mat']
save(saveStr, 'ImReader');

fprintf(' [DONE]\n');
