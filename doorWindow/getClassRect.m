%function hibaapclassifyRectangles(Dataset,saveImage);
% RECTANGLE CLASSIFICATION

% load hibaap values

% clear;
% cd ..
% setup
% cd doorWindow
% 
saveImage = false;
% %Dataset.fileShort='Ort1'
% %Dataset.fileShort='OrtCrop1'
% Dataset.fileShort='Spil1TransCrop1';
% load([startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_hibaap.mat']);
% 
% if exist('Dataset')==0
% 	error('tj:Dataset not loaded')
% end

%fgHough = figure();imshow(Dataset.ImReader.imOriDimmed); hold on;
%plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);
[Dataset.HoughResult.V.LinesIm,Dataset.HoughResult.H.LinesIm] = houghlinesToIm(Dataset,0)

% show image
%figure;imshow(Dataset.ImReader.imEdge);hold on;
%plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);
%plotPeakLines(Dataset);

% add origin and endpoint to peak array so it can be used as a range
XvHistMaxPeaks = [1,Dataset.Hibaap.XvHistMaxPeaks, Dataset.ImReader.imWidth];
YhHistMaxPeaks = [1,Dataset.Hibaap.YhHistMaxPeaks,Dataset.ImReader.imHeight];

% declare vars
tempIm = zeros(Dataset.ImReader.imHeight,Dataset.ImReader.imWidth,1);
imHoughPxCountX = tempIm;
imHoughPxCountY = tempIm;


% SUM UP HOUGHLINE PICS 
% loop through vertical strokes
for i=2:length(XvHistMaxPeaks)
	x1 = XvHistMaxPeaks(i-1); x2 = XvHistMaxPeaks(i);
	houghStroke	= Dataset.HoughResult.H.LinesIm(:,x1:x2);
	houghStrokeTotal= sum(sum(houghStroke));
	houghStrokeNorm=houghStrokeTotal/(size(houghStroke,1)*size(houghStroke,2));
	imHoughPxCountX(:,x1:x2) = houghStrokeNorm;
	WindowsColVote(i) = houghStrokeNorm;
end
% loop through horizontal strokes
for j=2:length(YhHistMaxPeaks)
	y1 = YhHistMaxPeaks(j-1); y2 = YhHistMaxPeaks(j);
	houghStroke	= Dataset.HoughResult.V.LinesIm(y1:y2,:);
	houghStrokeTotal= sum(sum(houghStroke));
	houghStrokeNorm=houghStrokeTotal/(size(houghStroke,1)*size(houghStroke,2));
	imHoughPxCountY(y1:y2,:) = houghStrokeNorm;
	WindowsRowVote(j) = houghStrokeNorm;
end


% CLUSTERING hough 
% use 2 clusters and transfor 211121 into 100010
[WindowsColVoteBin, Clusters] = kmeans(WindowsColVote,2);
[t_, maxClusterIdx] = max(Clusters);
% set a 1 at the clusters associated with highest bin
WindowsColVoteBin = WindowsColVoteBin'==maxClusterIdx;

[WindowsRowVoteBin, Clusters] = kmeans(WindowsRowVote,2);
[t_, maxClusterIdx] = max(Clusters);
WindowsRowVoteBin = WindowsRowVoteBin'==maxClusterIdx;


% PLOT VERTICAL HOUGHLINE amounts
%fgLinesImV = figure();imshow(imdilate(Dataset.HoughResult.V.LinesIm,ones(5,5))); hold on;
voteGraphWidth = (Dataset.ImReader.imWidth/10); voteGraphFactor = voteGraphWidth/max(WindowsRowVote);
for j=2:length(WindowsRowVote)
	y1 = YhHistMaxPeaks(j-1); y2 = YhHistMaxPeaks(j);
	x = voteGraphFactor*WindowsRowVote(j);
	if WindowsRowVoteBin(j)
		plot([x,x],[y1,y2],'g-','lineWidth', 3);
	else
		plot([x,x],[y1,y2],'r-','lineWidth', 3);
	end
end
% PLOT HORIZONTAL HOUGHLINE amounts
%fgLinesImH = figure();imshow(imdilate(Dataset.HoughResult.H.LinesIm,ones(5,5))); hold on;
voteGraphHeight = (Dataset.ImReader.imHeight/10); voteGraphFactor = voteGraphHeight/max(WindowsColVote);
for i=2:length(WindowsColVote)
	x1 = XvHistMaxPeaks(i-1); x2 = XvHistMaxPeaks(i);
	y = (Dataset.ImReader.imHeight-(voteGraphFactor*WindowsColVote(i)));
	if WindowsColVoteBin(i)
		plot([x1,x2],[y,y],'g-','lineWidth', 3);
	else
		plot([x1,x2],[y,y],'r-','lineWidth', 3);
	end
end


% drawing the windows
fgimWindows=figure();imshow(Dataset.ImReader.imOriDimmed);hold on;
%fgimHoughPxCountSumXY  		= figure();imshow(imHoughPxCountX+imHoughPxCountY,[]);
%hold on;

%Dataset.ImReader.imWidth Dataset.ImReader.imHeight]);
for i=2:length(XvHistMaxPeaks)
	%WindowsColVote(i)
	for j=2:length(YhHistMaxPeaks)
		%WindowsColVote(j)
		X = [XvHistMaxPeaks(i),XvHistMaxPeaks(i), XvHistMaxPeaks(i-1),XvHistMaxPeaks(i-1),XvHistMaxPeaks(i)];
		Y = [YhHistMaxPeaks(j),YhHistMaxPeaks(j-1), YhHistMaxPeaks(j-1),YhHistMaxPeaks(j),YhHistMaxPeaks(j)];

		probV = 100*WindowsColVote(i);
		probH = 100*WindowsRowVote(j);
		probVH = probV+probH;
		%probStr = sprintf('V %0.2f\nH %0.2f\nT %0.2f', probV, probH, probVH)
		%probStr = sprintf('V %0.1f\nH %0.1f\nT %0.1f', probV, probH, probVH)
		probStr = sprintf('%0.1f', probVH)
		% %annotation(fgimWindows,'textbox', [x y 0.1 0.1 ], 'String',probStr);
		text(XvHistMaxPeaks(i-1)+10, YhHistMaxPeaks(j-1)+30, probStr);

		% % width of rect 
		% if WindowsColVoteBin(i) && WindowsRowVoteBin(j)
		% 	colorStr = 'g-';
		% else
		% 	colorStr = 'k--';
		% end
		% plot(X,Y, colorStr, 'LineWidth',max(1,round(2*probVH)));

		if WindowsColVoteBin(i) && WindowsRowVoteBin(j)
			colorStr = 'g-';
			plot(X,Y, colorStr, 'LineWidth',3);
		end
		% if WindowsColVoteBin(i) && WindowsRowVoteBin(j)
		% 	colorStr = 'g-';
		% 	plot(X,Y, colorStr, 'LineWidth',3);
		% elseif WindowsColVoteBin(i) 
		% 	colorStr = 'k--';
		% 	plot(X,Y, colorStr, 'LineWidth',1);
		% elseif WindowsRowVoteBin(j)
		% 	colorStr = 'k--';
		% 	plot(X,Y, colorStr, 'LineWidth',1);
		% end

	end
		pause;
end

pause;

% draw binary stroke images 
if true
	fgimOri 					= figure();imshow(Dataset.ImReader.imOri,[]);
	fgimEdge 					= figure();imshow(Dataset.ImReader.imEdge,[]);
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





