function imEdge = getEdge(ImReader, EdgeDetectorParam)

% EDGE TEST
if EdgeDetectorParam.edgeTest
	for thresh=0.05:0.05:0.8
		tic;
		thresh
		imEdge = im2double(edge(ImReader.imColorModelTransform, EdgeDetectorParam.type, thresh));
		figure(round(thresh*100));
		imshow(imEdge);
		toc;
	end
	error('edge test done, ending program')
end

% EDGE DETECTION 
imEdge = im2double(edge(ImReader.imColorModelTransform, EdgeDetectorParam.type, EdgeDetectorParam.thresh));
