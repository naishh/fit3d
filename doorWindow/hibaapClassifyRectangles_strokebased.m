function hibaapclassifyRectangles(Dataset,saveImage);
XvHistMaxPeaks = Dataset.Hibaap.XvHistMaxPeaks; 
YhHistMaxPeaks = Dataset.Hibaap.YhHistMaxPeaks;
% RECTANGLE CLASSIFICATION
% add borders
XvHistMaxPeaks = [1,XvHistMaxPeaks,Dataset.imWidth];
YhHistMaxPeaks = [1,YhHistMaxPeaks,Dataset.imHeight];



% TODO iets meer dan randen meenemen, ranges veranderen, uitbreiden
tempIm = zeros(Dataset.imHeight,Dataset.imWidth,1);
imEdgeCountX = tempIm;
imEdgeCountY = tempIm;
imEdgeCountBinX = tempIm;
imEdgeCountBinY = tempIm;

% loop through vertical strokes
edgeStrokeNormArray = zeros(length(XvHistMaxPeaks),1)
for i=2:length(XvHistMaxPeaks)
	x1 = XvHistMaxPeaks(i-1);
	x2 = XvHistMaxPeaks(i);
	edgeStroke	= Dataset.imEdge(:,x1:x2);
	edgeStrokeTotal= sum(sum(edgeStroke));
	edgeStrokeNorm=edgeStrokeTotal/(size(edgeStroke,1)*size(edgeStroke,2));
	imEdgeCountX(:,x1:x2) = edgeStrokeNorm;
	edgeStrokeNormArray(i-1) = edgeStrokeNorm;
	%imshow(imEdgeCountX,[]); pause;
	if edgeStrokeNorm<=Dataset.hibaapParam.edgeStrokeThreshX 
		binVal = 0;
	else
		binVal = 1;
	end
	imEdgeCountBinX(:,x1:x2) = binVal;
end
edgeStrokeNormArray

disp('now for y');
% loop through horizontal strokes
edgeStrokeNormArray = zeros(length(YhHistMaxPeaks),1)
for j=2:length(YhHistMaxPeaks)
	y1 = YhHistMaxPeaks(j-1);
	y2 = YhHistMaxPeaks(j);
	edgeStroke	= Dataset.imEdge(y1:y2,:);
	edgeStrokeTotal= sum(sum(edgeStroke));
	edgeStrokeNorm=edgeStrokeTotal/(size(edgeStroke,1)*size(edgeStroke,2));
	imEdgeCountY(y1:y2,:) = edgeStrokeNorm;
	edgeStrokeNormArray(j-1) = edgeStrokeNorm;
	%pause, y1,y2,j,edgeStrokeNorm, imshow(imEdgeCountY,[]); 
	if edgeStrokeNorm<=Dataset.hibaapParam.edgeStrokeThreshY 
		binVal = 0;
	else
		binVal = 1;
	end
	imEdgeCountBinY(y1:y2,:) = binVal;
end

edgeStrokeNormArray
sumBinXBinY 			= imEdgeCountBinX+imEdgeCountBinY;

fgimOri 				= figure();imshow(Dataset.imOri,[]);
fgimEdge 				= figure();imshow(Dataset.imEdge,[]);
fgimEdgeCountX 			= figure();imshow(imEdgeCountX,[]);
fgimEdgeCountBinX  		= figure();imshow(imEdgeCountBinX,[]);
fgimEdgeCountY 			= figure();imshow(imEdgeCountY,[]);
fgimEdgeCountBinY  		= figure();imshow(imEdgeCountBinY,[]);
fgimEdgeCountSum  		= figure();imshow(imEdgeCountX+imEdgeCountY,[]);
fgimEdgeCountBinSum  	= figure();imshow(sumBinXBinY ,[]);
fgimEdgeCountBinSumBin  = figure();imshow(sumBinXBinY==2,[]);


if saveImage
	disp('saving images..');
	savePath 						= ['resultsHibaap/',Dataset.fileShort,'/'];
	% save images
	saveas(fgimOri 				,[savePath,'00_fgimOri.png'],'png'); 
	saveas(fgimEdge 			,[savePath,'02_fgimEdge.png'],'png'); 
	saveas(fgimEdgeCountX 		,[savePath,'05_classifyRects_fgimEdgeCountX.png'],'png'); 
	saveas(fgimEdgeCountBinX	,[savePath,'10_classifyRects_fgimEdgeCountBinX.png'],'png'); 
	saveas(fgimEdgeCountY 		,[savePath,'15_classifyRects_fgimEdgeCountY.png'],'png'); 
	saveas(fgimEdgeCountBinY	,[savePath,'20_classifyRects_fgimEdgeCountBinY.png'],'png'); 
	saveas(fgimEdgeCountSum		,[savePath,'25_classifyRects_fgimEdgeCountSum.png'],'png'); 
	saveas(fgimEdgeCountBinSum  ,[savePath,'30_classifyRects_fgimEdgeCountBinSum.png'],'png'); 
	saveas(fgimEdgeCountBinSumBin,[savePath,'35_classifyRects_fgimEdgeCountBinSumBin.png'],'png');
	disp('done!');
end
% END rectangle classification ----------------------------------------------------------------------------------

