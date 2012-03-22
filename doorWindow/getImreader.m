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


ImReader.imColorModelTransform   = getColorModelTransform(ImReader.imCropped, Dataset);

% perform edge detection
ImReader.imEdge = getEdge(ImReader, Dataset.EdgeDetectorParam);
if plotmeImEdge
	figure;imshow(ImReader.imEdge)
end

% save to disk var
saveStr = [startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_ImReader.mat']
save(saveStr, 'ImReader');

fprintf(' [DONE]\n');
