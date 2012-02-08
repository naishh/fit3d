fprintf('\nStarting imReader...');
clear imReader

% read file
imReader.imOri 					= imread(Dataset.file);
imReader.imOriDimmed 			= 0.8*Dataset.imOri;
imReader.imHeight 				= size(Dataset.imOri, 1);
imReader.imWidth					= size(Dataset.imOri, 2);

% transform color
imReader.imColorModelTransform   = getColorModelTransform(Dataset.imOri, Dataset);
% perform edge detection
imReader.imEdge = getEdge(Dataset, Dataset.EdgeDetectorParam.edgeTest);

% save to local var
Dataset.imReader = imReader

% save to disk var
saveStr = [startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_imReader.mat']
save(saveStr, 'imReader');

fprintf(' [DONE]\n');
