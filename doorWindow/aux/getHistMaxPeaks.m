function XvHistMaxPeaks = getHistMaxPeaks(Dataset, XvHistSmooth, XvThresh, plotme);
XvPeaksBinary = XvHistSmooth>=XvThresh;
XvHistMaxPeak = intmin;
k=1;
for i=2:length(XvPeaksBinary)
	% detect where peak ends 
	if [XvPeaksBinary(i-1),XvPeaksBinary(i)] == [1,0]
		% plot vertical line of peakmax
		if plotme
			plot([XvHistMaxPeakIdx,XvHistMaxPeakIdx],[0,Dataset.imHeight],'g-','LineWidth',2);
		end
		% store peak
		XvHistMaxPeaks(k) = XvHistMaxPeakIdx; k = k+1;
		% reset max'
		XvHistMaxPeak = intmin;
		XvHistMaxPeakIdx = 0;
	elseif XvPeaksBinary(i) == 1 % peak starts
		% take area and take maximum peak value
		if XvHistSmooth(i) > XvHistMaxPeak 
			% update max
			XvHistMaxPeak = XvHistSmooth(i);
			% store idx of max peakvalue
			XvHistMaxPeakIdx = i;
		end
	end
end
