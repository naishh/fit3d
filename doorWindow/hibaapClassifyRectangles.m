%function hibaapclassifyRectangles(Dataset,saveImage);
% RECTANGLE CLASSIFICATION
saveImage = true

% load hibaap values

%Dataset.fileShort='Ort1'
%Dataset.fileShort='Spil1TransCrop1'
Dataset.fileShort='OrtCrop1'
load([startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_hibaap.mat']);

if exist('Dataset')==0
	error('tj:Dataset not loaded')
end

[Dataset.HoughResult.V.LinesIm,Dataset.HoughResult.H.LinesIm] = houghlinesToIm(Dataset,0)

% show image
%figure;imshow(Dataset.imEdge);hold on;
%plotHoughlinesAll(Dataset.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);
%plotPeakLines(Dataset);

% add origin and endpoint to peak array so it can be used as a range
XvHistMaxPeaks = [1,Dataset.Hibaap.XvHistMaxPeaks, Dataset.imWidth];
YhHistMaxPeaks = [1,Dataset.Hibaap.YhHistMaxPeaks,Dataset.imHeight];

% declare vars
tempIm = zeros(Dataset.imHeight,Dataset.imWidth,1);
imHoughPxCountX = tempIm;
imHoughPxCountY = tempIm;


% loop through vertical strokes
for i=2:length(XvHistMaxPeaks)
	x1 = XvHistMaxPeaks(i-1); x2 = XvHistMaxPeaks(i);
	edgeStroke	= Dataset.HoughResult.H.LinesIm(:,x1:x2);
	edgeStrokeTotal= sum(sum(edgeStroke));
	edgeStrokeNorm=edgeStrokeTotal/(size(edgeStroke,1)*size(edgeStroke,2));
	imHoughPxCountX(:,x1:x2) = edgeStrokeNorm;
	WindowsColVote(i) = edgeStrokeNorm;
end
% loop through horizontal strokes
for j=2:length(YhHistMaxPeaks)
	y1 = YhHistMaxPeaks(j-1); y2 = YhHistMaxPeaks(j);
	edgeStroke	= Dataset.HoughResult.V.LinesIm(y1:y2,:);
	edgeStrokeTotal= sum(sum(edgeStroke));
	edgeStrokeNorm=edgeStrokeTotal/(size(edgeStroke,1)*size(edgeStroke,2))
	imHoughPxCountY(y1:y2,:) = edgeStrokeNorm;
	WindowsRowVote(j) = edgeStrokeNorm;
	%pause, y1,y2,j,edgeStrokeNorm, imshow(imHoughPxCountY,[]); 
end

%% overrule thresholds by auto threshold (average val)
%Dataset.HibaapParam.edgeStrokeThreshX   = sum(WindowsColVote)/(length(WindowsColVote)-1);
%Dataset.HibaapParam.edgeStrokeThreshY   = sum(WindowsRowVote)/(length(WindowsRowVote)-1);
% use middelste getal van sorted lijst
%Dataset.HibaapParam.edgeStrokeThreshX   = WindowsColVote(round((length(WindowsColVote)-1)/2));
%Dataset.HibaapParam.edgeStrokeThreshY   = WindowsColVote(round((length(WindowsRowVote)-1)/2));
% kmeans makes dataset of 111 and 222
WindowsColVoteBin = (kmeans(WindowsColVote,2) == 2)
pause;
WindowsRowVoteBin = (kmeans(WindowsRowVote,2) == 2)
pause;
%% make values binary 
%WindowsColVoteBin = WindowsColVote>=Dataset.HibaapParam.edgeStrokeThreshX;
%WindowsRowVoteBin = WindowsRowVote>=Dataset.HibaapParam.edgeStrokeThreshY;


% drawing the windows
fgimWindows=figure();imshow(Dataset.imOriDimmed);hold on;
for i=2:length(XvHistMaxPeaks)
	%WindowsColVote(i)
	for j=2:length(YhHistMaxPeaks)
		%WindowsColVote(j)
		X = [XvHistMaxPeaks(i),XvHistMaxPeaks(i), XvHistMaxPeaks(i-1),XvHistMaxPeaks(i-1),XvHistMaxPeaks(i)];
		Y = [YhHistMaxPeaks(j),YhHistMaxPeaks(j-1), YhHistMaxPeaks(j-1),YhHistMaxPeaks(j),YhHistMaxPeaks(j)];
		if WindowsColVoteBin(i) && WindowsRowVoteBin(j)
			colorStr = 'g-';
			plot(X,Y, colorStr, 'LineWidth',2);
		elseif WindowsColVoteBin(i) 
			colorStr = 'b-';
			plot(X,Y, colorStr, 'LineWidth',1);
		elseif WindowsRowVoteBin(j)
			colorStr = 'r-';
			plot(X,Y, colorStr, 'LineWidth',1);
		end
	end
end


% draw binary stroke images 
if true
	fgimOri 					= figure();imshow(Dataset.imOri,[]);
	fgimEdge 					= figure();imshow(Dataset.imEdge,[]);
	fgimHoughPxCountX 			= figure();imshow(imHoughPxCountX,[]);
	fgimHoughPxCountY 			= figure();imshow(imHoughPxCountY,[]);
	fgimHoughPxCountSumXY  		= figure();imshow(imHoughPxCountX+imHoughPxCountY,[]);

end

if saveImage
	disp('saving images..');
	savePath 						= ['resultsHibaap/',Dataset.fileShort,'/'];
	% save images
	saveas(fgimOri 				,[savePath,'00_fgimOri.png'],'png'); 
	saveas(fgimEdge 			,[savePath,'02_fgimEdge.png'],'png'); 
	saveas(fgimHoughPxCountX 		,[savePath,'05_classifyRects_fgimHoughPxCountX.png'],'png'); 
	saveas(fgimHoughPxCountY 		,[savePath,'15_classifyRects_fgimHoughPxCountY.png'],'png'); 
	saveas(fgimHoughPxCountSumXY,[savePath,'25_classifyRects_fgimHoughPxCountSumXY.png'],'png'); 
	saveas(fgimWindows,[savePath,'30_classifyRects_fgimWindows.png'],'png');
	disp('done!');
end





