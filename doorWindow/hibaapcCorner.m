function hibaapcCorner(Dataset)
%TODO
%mincCornerVotes = Dataset.cCornerParam.minVotes;
mincCornerVotes = 1;
maxWindowSize = 200;
cornerInlierThreshold = 0.2;%0.2
Dataset.HoughResult.Houghlines = getcCorner(Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot,cornerInlierThreshold,maxWindowSize);

disp('plotting cCorner windows'); 
% new figure
pause; figure;imshow(Dataset.imOriDimmed); hold on;
plotcCorners(Dataset.HoughResult.Houghlines, Dataset.HoughResult.HoughlinesRot, 'cCorner', false)


disp('plotting histograms and cCorner windows fused'); 
pause; figure;imshow(Dataset.imOriDimmed); hold on;

% loop through cCorners and draw window @ 4 nearby crossings from kwadrants
WindowsUnique = cell(0);
w = 1;
for i=1:length(Dataset.HoughResult.Houghlines)
	for k=1:length(Dataset.HoughResult.Houghlines(i).cCorners)
		cCorner = Dataset.HoughResult.Houghlines(i).cCorners(k);
		%plotcCorner(cCorner,'cCorner');
		% get midpoint of cCorner
		winX = cCorner.windowMidpointX;
		winY = cCorner.windowMidpointY;
		% plot blue cross in window
		plot(winX, winY, 'b+');
		%pause;

		% perform quadrant selection
		% gets the edge peak crossings kwadrants with the midpoint of window as origin
		EpcLeft 		= EdgePeakCrossings(EdgePeakCrossings(:,1)<=winX,:);
		EpcLeftTop 		= EpcLeft(EpcLeft(:,2)<=winY,:);
		EpcLeftBottom 	= EpcLeft(EpcLeft(:,2)>winY,:);
		EpcRight 		= EdgePeakCrossings(EdgePeakCrossings(:,1)>winX, :);
		EpcRightTop 	= EpcRight(EpcRight(:,2)<=winY, :);
		EpcRightBottom 	= EpcRight(EpcRight(:,2)>winY, :);

		% minimum four crossings need to be found to create a window
		if size(EpcLeftTop,1)>0 && size(EpcRightTop,1)>0 && size(EpcRightBottom,1)>0 &&size(EpcLeftBottom,1)>0

			% get closest crossing from crossings quadrant selection
			Windows{w}.lt 	 			= getClosestPointInArray([winX,winY],EpcLeftTop);
			Windows{w}.rt 	 			= getClosestPointInArray([winX,winY],EpcRightTop);
			Windows{w}.rb 	 			= getClosestPointInArray([winX,winY],EpcRightBottom);
			Windows{w}.lb 	 			= getClosestPointInArray([winX,winY],EpcLeftBottom);
			Windows{w}.width 			= Windows{w}.rt(1) - Windows{w}.lt(1);
			Windows{w}.height			= Windows{w}.rb(2) - Windows{w}.rt(2);
			Windows{w}.windowMidpointX  = winX;
			Windows{w}.windowMidpointY  = winY;
			% collect coords for window
			X = [Windows{w}.lt(1), Windows{w}.rt(1), Windows{w}.rb(1), Windows{w}.lb(1),Windows{w}.lt(1)];
			Y = [Windows{w}.lt(2), Windows{w}.rt(2), Windows{w}.rb(2), Windows{w}.lb(2),Windows{w}.lt(2)];
			% create unique hash
			Windows{w}.hash = int2str([X,Y]);
			% plot window
			%plot(X, Y, 'g-','LineWidth',4);


			% hash functionality
			foundWindow = false;
			for u=1:length(WindowsUnique);
				if strcmp(WindowsUnique{u}.hash, Windows{w}.hash)
					WindowsUnique{u}.votes = WindowsUnique{u}.votes + 1;
					foundWindow = true;
				end
			end
			% initialize a windowunique entry
			if foundWindow == false
				idx = length(WindowsUnique)+1;
				WindowsUnique{idx} = Windows{w};
				WindowsUnique{idx}.votes = 1;
			end

			w = w + 1;
		else
			disp('no nearby crossings found.. i,k');
			i,k
		end
	end
end



% loop through windows unique and plot them with outliers
ww = 1;
for w=1:length(WindowsUnique)
	WindowsUnique{w}.votes
	% collect coords for windowsUnique
	X = [WindowsUnique{w}.lt(1), WindowsUnique{w}.rt(1), WindowsUnique{w}.rb(1), WindowsUnique{w}.lb(1),WindowsUnique{w}.lt(1)];
	Y = [WindowsUnique{w}.lt(2), WindowsUnique{w}.rt(2), WindowsUnique{w}.rb(2), WindowsUnique{w}.lb(2),WindowsUnique{w}.lt(2)];
	% if is inlier
	if WindowsUnique{w}.votes>=mincCornerVotes
		WindowsUniqueNoOutliers{ww} = WindowsUnique{w}; ww=ww+1;
		colorStr = 'g-';
		% plot windowsUnique
		plot(X, Y, colorStr,'LineWidth',4);
	else
		colorStr = 'r-';
		% plot big red outlier cross in window
		plot(WindowsUnique{w}.windowMidpointX, WindowsUnique{w}.windowMidpointY, 'r+', 'MarkerSize',10);
		% plot windowsUnique
		plot(X, Y, colorStr,'LineWidth',2);
	end
end
