function plotWindows(WindowsMerged,nrWindowsMax)
% plot windows 
for w=1:length(WindowsMerged)
	w
	% amound of black = 1-white, take minimum 0.2 else you dont see it
	grayScale = max(0.2,1-(WindowsMerged{w}.nrWindows/nrWindowsMax));
	grayScale = [grayScale, grayScale, grayScale];
	if WindowsMerged{w}.nrWindows>=1
		%plotWindowColored(WindowsMerged{w}.x,WindowsMerged{w}.y,WindowsMerged{w}.avgHWHalf(1),WindowsMerged{w}.avgHWHalf(2),grayScale);
		plotcCornerWindow(WindowsMerged{w})
		pause;
	end
end
