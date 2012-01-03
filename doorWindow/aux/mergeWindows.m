function [WindowsMerged,nrWindowsMax]  = mergeWindows(Windows,slidingWindowSize, stepSize)

% creates X and Y coords for a nxn filter
slidingWindowSize=21; h = ((slidingWindowSize-1)/2);
X = repmat(-h:h,1,slidingWindowSize);
Y = reshape(reshape(X,slidingWindowSize,slidingWindowSize)',1,slidingWindowSize*slidingWindowSize);

w = 1;
% generete ranges of x,y position sliding window
% sliding window starts at h+1
for i=h+1:stepSize:size(Windows,1)-h
	i
	for j=h+1:stepSize:size(Windows,2)-h
		nrWindows = 0;
		totHW = [0;0]; totvlineEnd=0; tothlineEnd=0; totcrossing=0;

		% inside sliding window X(k) and Y(k) have coords
		for k=1:slidingWindowSize*slidingWindowSize
			% window found
			if size(Windows{i+X(k),j+Y(k)},1)==1
				%Windows{i,j}.height
				nrWindows = nrWindows+1;
				% sum height widths of windows
				totHW = totHW + Windows{i+X(k),j+Y(k)}.hw;

				totvlineEnd=totvlineEnd+ Windows{i+X(k),j+Y(k)}.vlineEnd;
				tothlineEnd=tothlineEnd+ Windows{i+X(k),j+Y(k)}.hlineEnd;
				totcrossing=totcrossing+ Windows{i+X(k),j+Y(k)}.crossing;
			end
		end

		% if found a window in the sliding window
		if nrWindows>=1
			WindowsMerged{w}.nrWindows = nrWindows;
			WindowsMerged{w}.avgHWHalf = round((totHW/nrWindows)/2);
			WindowsMerged{w}.x = i;
			WindowsMerged{w}.y = j;

			WindowsMerged{w}.vlineEnd = round(totvlineEnd/nrWindows);
			WindowsMerged{w}.hlineEnd = round(tothlineEnd/nrWindows);
			WindowsMerged{w}.crossing = round(totcrossing/nrWindows);

			% update average height width of window
			avgHW = totHW / nrWindows;
			w = w + 1;
		end
	end
end

% determine max nr of windows
nrWindowsMax = 0;
for w=1:length(WindowsMerged)
	if WindowsMerged{w}.nrWindows > nrWindowsMax
		nrWindowsMax = WindowsMerged{w}.nrWindows;
	end
end
