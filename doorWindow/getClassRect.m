
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
w = Dataset.ImReader.imWidth; h = Dataset.ImReader.imHeight;
% setup histograms bins
XvBins = 1:1:w; YhBins = 1:1:h; YvBins = 1:1:h; XhBins = 1:1:w;


% smooth more to get one signchange per block
n = Dataset.ClassRectParam.smoothNtimes;
XhHistDerSmooth = smoothNtimes(Dataset.Hibaap.XhHistDerSmooth,n); 
XhHistSmooth = smoothNtimes(Dataset.Hibaap.XhHistSmooth,n); 

figure; imshow(Dataset.ImReader.imOriDimmed); hold on;

%quickfix for right legend
plot([0,0],[0,0],'k--'); plot([0,0],[0,0],'r-'); plot([0,0],[0,0],'b-');

% plot window alignment lines
plotPeakLines(Dataset);
% plot zero line
%plot([0,Dataset.ImReader.imWidth],[Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing, Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing],'k--','LineWidth',2);

pause;

% colvote by signchanges 
for i=2:length(XvHistMaxPeaks)
	i
	x1 = XvHistMaxPeaks(i-1); x2 = XvHistMaxPeaks(i);
	D = XhHistDerSmooth(x1:x2)'
	plot(XhBins(x1:x2), Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing-D,'k-', 'LineWidth',2);
	plot(XhBins(x1:x2), Dataset.ImReader.imHeight-6*Dataset.Hibaap.graphSpacing-XhHistSmooth(x1:x2),'r-','LineWidth',2);
	plot(XhBins(1:length(Dataset.Hibaap.XhHistDerSmooth)), Dataset.ImReader.imHeight-6*Hibaap.graphSpacing-XhHistDerSmooth,'b-', 'LineWidth',2);
	signChanges = getSignChanges(D)

	
	% MODE everything is a window except for non window areas
	WindowsColVoteBin(i) = 1;
	if length(signChanges) > 0 
		% this was for spil!
		id = signChanges(1);
		% take first signChange, alternative, get midle one
		% check if it is a dal
		if D(id) < D(id+1) 
			WindowsColVoteBin(i) = 0;
		end
	end
	WindowsColVoteBin(i);
	% while length(signChanges) > 1 
	% 	length(signChanges) 
	% 	disp('smoothing ');
	% 	smoothNtimes(XhHistDerSmooth,1);
	% 	signChanges = getSignChanges(D)
	% 	pause;
	% end
	% pause;
	%WindowsColVote(i) = houghStrokeNorm;
end

legend( 'Merged window alignment lines',...
		'Xh: total amount of overlapping horizontal Houghlines at each x position',...
		'E: derivative of Xh');

%quickfix
WindowsColVoteBin( length(WindowsColVoteBin) ) = 0;
WindowsColVoteBin( 1 ) = 0;
WindowsColVoteBin( 2 ) = 0;
WindowsColVoteBin( 3 ) = 0;

% declare vars
tempIm = zeros(Dataset.ImReader.imHeight,Dataset.ImReader.imWidth,1);
imHoughPxCountX = tempIm;
imHoughPxCountY = tempIm;

% SUM UP HOUGHLINE PICS 
% loop through horizontal strokes
for j=2:length(YhHistMaxPeaks)
	y1 = YhHistMaxPeaks(j-1); y2 = YhHistMaxPeaks(j);
	houghStroke	= Dataset.HoughResult.V.Im(y1:y2,:);
	houghStrokeTotal= sum(sum(houghStroke));
	houghStrokeNorm=houghStrokeTotal/(size(houghStroke,1)*size(houghStroke,2));
	imHoughPxCountY(y1:y2,:) = houghStrokeNorm;
	WindowsRowVote(j) = houghStrokeNorm;
end



% CLUSTERING hough 
[WindowsRowVoteBin, Clusters] = kmeans(WindowsRowVote,2);
[t_, maxClusterIdx] = max(Clusters);
WindowsRowVoteBin = WindowsRowVoteBin'==maxClusterIdx;


% drawing the windows
fgimWindows=figure();imshow(Dataset.ImReader.imOriDimmed);hold on;

% plot small green windows
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
			colorStr = 'b-';
			plot(X,Y, colorStr, 'LineWidth',1);
		else
		 	colorStr = 'b--';
		 	plot(X,Y, colorStr, 'LineWidth',1);
		end

	end
	%	pause;
end


% exctract big red rectangles base upon change 01 or 10 in colbin
k=1
for i=2:length(WindowsColVoteBin)
	if ~WindowsColVoteBin(i-1) && WindowsColVoteBin(i)  
		WindowsColVoteBinBig(k) = 0;
		XvHistMaxPeaksBig(k) = XvHistMaxPeaks(i-1)
		k=k+1;
	end
	if WindowsColVoteBin(i-1) && ~WindowsColVoteBin(i)  
		WindowsColVoteBinBig(k) = 1;
		XvHistMaxPeaksBig(k) = XvHistMaxPeaks(i-1)
		k=k+1;
	end
end
k=1
for i=2:length(WindowsRowVoteBin)
	if ~WindowsRowVoteBin(i-1) && WindowsRowVoteBin(i)  
		WindowsRowVoteBinBig(k) = 0;
		YhHistMaxPeaksBig(k) = YhHistMaxPeaks(i-1)
		k=k+1;
	end
	if WindowsRowVoteBin(i-1) && ~WindowsRowVoteBin(i)  
		WindowsRowVoteBinBig(k) = 1;
		YhHistMaxPeaksBig(k) = YhHistMaxPeaks(i-1)
		k=k+1;
	end
end

%draw big red rectangles
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

%figure(fgimWindows)

