fprintf('\nStarting ImReader...');

% read file
ImReader.imOri 					= imread(ImReader.file);
ImReader.imOriDimmed 			= 0.8*ImReader.imOri;
ImReader.imHeight 				= size(ImReader.imOri, 1);
ImReader.imWidth					= size(ImReader.imOri, 2);

% transform color
ImReader.imColorModelTransform   = getColorModelTransform(ImReader.imOri, Dataset);

% perform edge detection
ImReader.imEdge = getEdge(ImReader, Dataset.EdgeDetectorParam);
if plotmeImEdge
	figure;imshow(ImReader.imEdge)
end

% save to disk var
saveStr = [startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_ImReader.mat']
save(saveStr, 'ImReader');

fprintf(' [DONE]\n');
