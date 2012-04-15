
% new method
% count number of 0 crossings in Xhder
% + 0 - is peak
% - 0 + is dal
% sign change of derivative
%
% if 1 found
%	check 5 px left and right for pattern (down/up)
% if multiple found iterative smooth Xh function  until 1 is found :D
%
%maybe also take hight of peak in Xh into account

% RECTANGLE CLASSIFICATION

saveImage = true;
savePath 						= ['resultsHibaap/',Dataset.fileShort,'/'];
%fgHough = figure();imshow(Dataset.ImReader.imOriDimmed); hold on;
%plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);

% show image
%fgPeaklines = figure();imshow(Dataset.ImReader.imEdge);hold on;
%plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);
%plotPeakLines(Dataset);

% add left and right tale (origin and endpoint) to peak array so it can be used as a range
XvHistMaxPeaks = [1,Dataset.Hibaap.XvHistMaxPeaks, Dataset.ImReader.imWidth];
YhHistMaxPeaks = [1,Dataset.Hibaap.YhHistMaxPeaks,Dataset.ImReader.imHeight];


% declare vars
XhHistSmoothDer = Dataset.Hibaap.XhHistSmoothDer; 
XhHistSmooth = Dataset.Hibaap.XhHistSmooth; 


figure;
hold on;


w = Dataset.ImReader.imWidth; h = Dataset.ImReader.imHeight;
% setup histograms bins
XvBins = 1:1:w; YhBins = 1:1:h; YvBins = 1:1:h; XhBins = 1:1:w;

figure; imshow(Dataset.ImReader.imOriDimmed); hold on;
plotPeakLines(Dataset);
%plot(XhBins, Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing-XhHistSmooth,'y-', 'LineWidth',2);
%plot(XhBins(1:length(XhHistSmoothDer)), Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing-XhHistSmoothDer,'b-', 'LineWidth',2);

plot([0,Dataset.ImReader.imWidth],[Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing, Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing],'k--','LineWidth',2);
pause;

% todo better plotting
for i=2:length(XvHistMaxPeaks)
	i
	x1 = XvHistMaxPeaks(i-1); x2 = XvHistMaxPeaks(i);
	D = XhHistSmoothDer(x1:x2)'
	plot(XhBins(x1:x2), Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing-D,'k-', 'LineWidth',2);
	plot(XhBins(x1:x2), Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing-XhHistSmooth(x1:x2),'g-','LineWidth',2);
	pause;
	signChanges = getSignChanges(D)

	WindowsColVote(i) = 0
	if length(signChanges) > 0 
		id = signChanges(1) 
		% take first signChange, alternative, get midle one
		if D(id) > D(id+1) 
			WindowsColVote(i) = 1
		end
	end
	% while length(signChanges) > 1 
	% 	length(signChanges) 
	% 	disp('smoothing ');
	% 	smoothNtimes(XhHistSmoothDer,1);
	% 	signChanges = getSignChanges(D)
	% 	pause;
	% end
	% pause;
	%WindowsColVote(i) = houghStrokeNorm;
end

% SUM UP HOUGHLINE PICS 
% loop through vertical strokes
for i=2:length(XvHistMaxPeaks)
	x1 = XvHistMaxPeaks(i-1); x2 = XvHistMaxPeaks(i);
	WindowsColVote(i) = houghStrokeNorm;
end
% loop through horizontal strokes
for j=2:length(YhHistMaxPeaks)
	y1 = YhHistMaxPeaks(j-1); y2 = YhHistMaxPeaks(j);
	houghStroke	= Dataset.HoughResult.V.Im(y1:y2,:);
	WindowsRowVote(j) = houghStrokeNorm;
end


% PLOT VERTICAL HOUGHLINE amounts
fgimHoughImV = figure();imshow(imdilate(Dataset.HoughResult.V.Im,ones(5,5))); hold on;
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
fgimHoughImH = figure();imshow(imdilate(Dataset.HoughResult.H.Im,ones(5,5))); hold on;
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

% plot small green windows
for i=2:length(XvHistMaxPeaks)
	%WindowsColVote(i)
	for j=2:length(YhHistMaxPeaks)
		%WindowsColVote(j)
		X = [XvHistMaxPeaks(i),XvHistMaxPeaks(i), XvHistMaxPeaks(i-1),XvHistMaxPeaks(i-1),XvHistMaxPeaks(i)];
		Y = [YhHistMaxPeaks(j),YhHistMaxPeaks(j-1), YhHistMaxPeaks(j-1),YhHistMaxPeaks(j),YhHistMaxPeaks(j)];

		probV = WindowsColVote(i)/max(WindowsColVote);
		probH = WindowsRowVote(j)/max(WindowsRowVote);
		probVH = (probV+probH)/2;
		probStr = sprintf('%0.1f', probVH);
		%text(XvHistMaxPeaks(i-1)+10, YhHistMaxPeaks(j-1)+30, probStr, 'BackgroundColor',[1 1 1]);

		if WindowsColVoteBin(i) && WindowsRowVoteBin(j)
			colorStr = 'g-';
			plot(X,Y, colorStr, 'LineWidth',2);
		elseif WindowsColVoteBin(i) 
			colorStr = 'b-';
			plot(X,Y, colorStr, 'LineWidth',1);
		elseif WindowsRowVoteBin(j)
			colorStr = 'b-';
			plot(X,Y, colorStr, 'LineWidth',1);
		else
		 	colorStr = 'b--';
		 	plot(X,Y, colorStr, 'LineWidth',1);
		end

	end
	%	pause;
end



% exctract big rectangles base upon change 01 or 10 in colbin
k=1
for i=2:length(WindowsColVoteBin)
	if ~WindowsColVoteBin(i-1) && WindowsColVoteBin(i)  
		WindowsColVoteBig(k)= WindowsColVote(i-1)
		WindowsColVoteBinBig(k) = 0;
		XvHistMaxPeaksBig(k) = XvHistMaxPeaks(i-1)
		k=k+1;
	end
	if WindowsColVoteBin(i-1) && ~WindowsColVoteBin(i)  
		WindowsColVoteBinBig(k) = 1;
		WindowsColVoteBig(k)= WindowsColVote(i-1)
		XvHistMaxPeaksBig(k) = XvHistMaxPeaks(i-1)
		k=k+1;
	end
end
k=1
for i=2:length(WindowsRowVoteBin)
	if ~WindowsRowVoteBin(i-1) && WindowsRowVoteBin(i)  
		WindowsRowVoteBinBig(k) = 0;
		WindowsRowVoteBig(k)= WindowsRowVote(i-1)
		YhHistMaxPeaksBig(k) = YhHistMaxPeaks(i-1)
		k=k+1;
	end
	if WindowsRowVoteBin(i-1) && ~WindowsRowVoteBin(i)  
		WindowsRowVoteBinBig(k) = 1;
		WindowsRowVoteBig(k)= WindowsRowVote(i-1)
		YhHistMaxPeaksBig(k) = YhHistMaxPeaks(i-1)
		k=k+1;
	end
end


for i=2:length(XvHistMaxPeaksBig)
	for j=2:length(YhHistMaxPeaksBig)
		if WindowsColVoteBinBig(i) && WindowsRowVoteBinBig(j)
			margin = 5;
			xOffset = margin*[1 1 -1 -1 1];
			yOffset = margin*[1 -1 -1 1 1];
			X = [XvHistMaxPeaksBig(i),XvHistMaxPeaksBig(i), XvHistMaxPeaksBig(i-1),XvHistMaxPeaksBig(i-1),XvHistMaxPeaksBig(i)];
			Y = [YhHistMaxPeaksBig(j),YhHistMaxPeaksBig(j-1), YhHistMaxPeaksBig(j-1),YhHistMaxPeaksBig(j),YhHistMaxPeaksBig(j)];
			colorStr = 'r-';
			plot(X+xOffset,Y+yOffset, colorStr, 'LineWidth',3);
		end
	end
end


if false

	% draw binary stroke images 
	fgimOri 					= figure();imshow(Dataset.ImReader.imOri,[]);
	fgimEdge 					= figure();imshow(Dataset.ImReader.imEdge,[]);
	fgimHoughPxCountX 			= figure();imshow(imHoughPxCountX,[]);
	fgimHoughPxCountY 			= figure();imshow(imHoughPxCountY,[]);
	fgimHoughPxCountSumXY  		= figure();imshow(imHoughPxCountX+imHoughPxCountY,[]);

	if saveImage
		disp('saving images..');
		% save images
		saveas(fgimOri 				,[savePath,'00_fgimOri.png'],'png'); 
		saveas(fgimEdge 			,[savePath,'02_fgimEdge.png'],'png'); 
		%saveas(fgimHoughPxCountX 		,[savePath,'05_ClassRect_fgimHoughPxCountX.png'],'png'); 
		%saveas(fgimHoughPxCountY 		,[savePath,'15_ClassRect_fgimHoughPxCountY.png'],'png'); 
		saveas(fgimHoughPxCountSumXY	,[savePath,'25_ClassRect_fgimHoughPxCountSumXY.png'],'png'); 
		saveas(fgimHoughImV 		,[savePath,'30_ClassRect_fgimHoughImV.png'],'png'); 
		saveas(fgimHoughImH 		,[savePath,'31_ClassRect_fgimHoughImH.png'],'png'); 
		saveas(fgimWindows				,[savePath,'40_ClassRect_fgimWindows.png'],'png');
		disp('done!');
	end

end

ClassRect.imGrayscaleProb = imHoughPxCountX+imHoughPxCountY;
figure(fgimWindows)

