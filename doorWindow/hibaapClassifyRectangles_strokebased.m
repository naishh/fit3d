%function hibaapclassifyRectangles(Dataset,saveImage);
% RECTANGLE CLASSIFICATION

% load hibaap values

Dataset.fileShort='Ort1'
%Dataset.fileShort='OrtCrop1'
load([startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_hibaap.mat']);

if exist('Dataset')==0
	error('tj:Dataset not loaded')
end

%[LinesImV,LinesImH] = houghlinesToIm(Dataset,0)

%figure;imshow(houghlinesIm,[])
%error('klaar');


%houghlinesRotIm = houghlinesToIm(Dataset.HoughResult.HoughlinesRot);

% show image
figure;imshow(Dataset.imEdge);hold on;
plotHoughlinesAll(Dataset.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);
plotPeakLines(Dataset);

% add origin and endpoint to peak array so it can be used as a range
XvHistMaxPeaks = [1,Dataset.Hibaap.XvHistMaxPeaks, Dataset.imWidth];
YhHistMaxPeaks = [1,Dataset.Hibaap.YhHistMaxPeaks,Dataset.imHeight];

% declare vars
tempIm = zeros(Dataset.imHeight,Dataset.imWidth,1);
imEdgeCountX = tempIm;
imEdgeCountY = tempIm;
imEdgeCountBinX = tempIm;
imEdgeCountBinY = tempIm;

% loop through vertical strokes
for i=2:length(XvHistMaxPeaks)
	x1 = XvHistMaxPeaks(i-1); x2 = XvHistMaxPeaks(i);
	edgeStroke	= Dataset.imEdge(:,x1:x2);
	edgeStrokeTotal= sum(sum(edgeStroke));
	edgeStrokeNorm=edgeStrokeTotal/(size(edgeStroke,1)*size(edgeStroke,2));
	imEdgeCountX(:,x1:x2) = edgeStrokeNorm;
	WindowsColVote(i) = edgeStrokeNorm;
	%imshow(imEdgeCountX,[]); pause;
	imEdgeCountBinX(:,x1:x2) = edgeStrokeNorm>Dataset.HibaapParam.edgeStrokeThreshX;
end
% loop through horizontal strokes
for j=2:length(YhHistMaxPeaks)
	y1 = YhHistMaxPeaks(j-1); y2 = YhHistMaxPeaks(j);
	edgeStroke	= Dataset.imEdge(y1:y2,:);
	edgeStrokeTotal= sum(sum(edgeStroke));
	edgeStrokeNorm=edgeStrokeTotal/(size(edgeStroke,1)*size(edgeStroke,2))
	imEdgeCountY(y1:y2,:) = edgeStrokeNorm;
	WindowsRowVote(j) = edgeStrokeNorm;
	%pause, y1,y2,j,edgeStrokeNorm, imshow(imEdgeCountY,[]); 
	imEdgeCountBinY(y1:y2,:) = edgeStrokeNorm>Dataset.HibaapParam.edgeStrokeThreshY;
end
% make values binary 
WindowsColVoteBin = WindowsColVote>Dataset.HibaapParam.edgeStrokeThreshX;
WindowsRowVoteBin = WindowsRowVote>Dataset.HibaapParam.edgeStrokeThreshY;




% draw binary stroke images 
if true
	sumBinXBinY 			= imEdgeCountBinX+imEdgeCountBinY;
	%fgimOri 				= figure();imshow(Dataset.imOri,[]);
	%fgimEdge 				= figure();imshow(Dataset.imEdge,[]);
	%fgimEdgeCountX 			= figure();imshow(imEdgeCountX,[]);
	%fgimEdgeCountBinX  		= figure();imshow(imEdgeCountBinX,[]);
	%fgimEdgeCountY 			= figure();imshow(imEdgeCountY,[]);
	%fgimEdgeCountBinY  		= figure();imshow(imEdgeCountBinY,[]);
	fgimEdgeCountSum  		= figure();imshow(imEdgeCountX+imEdgeCountY,[]);
	%fgimEdgeCountBinSum  	= figure();imshow(sumBinXBinY ,[]);
	%fgimEdgeCountBinSumBin  = figure();imshow(sumBinXBinY==2,[]);

end

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



% drawing the windows
figure;imshow(Dataset.imOriDimmed);hold on;
for i=2:length(XvHistMaxPeaks)
	%WindowsColVote(i)
	for j=2:length(YhHistMaxPeaks)
		%WindowsColVote(j)
		X = [XvHistMaxPeaks(i),XvHistMaxPeaks(i), XvHistMaxPeaks(i-1),XvHistMaxPeaks(i-1),XvHistMaxPeaks(i)];
		Y = [YhHistMaxPeaks(j),YhHistMaxPeaks(j-1), YhHistMaxPeaks(j-1),YhHistMaxPeaks(j),YhHistMaxPeaks(j)];
		if WindowsColVoteBin(i) && WindowsRowVoteBin(j)
			colorStr = 'r-';
			plot(X,Y, colorStr, 'LineWidth',2);
		else
			%colorStr = 'r-';
		end
	end
end

