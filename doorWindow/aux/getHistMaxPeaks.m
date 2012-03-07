function XvHistMaxPeaks = getHistMaxPeaks(Dataset, XvHistSmooth, XvThresh, plotme, direction);
%XvPeaksBinary = XvHistSmooth>=XvThresh;
XvPeaksBinary = XvHistSmooth>=0.3*max(XvHistSmooth);
XvHistMaxPeak = intmin;
k=1;
for i=2:length(XvPeaksBinary)
	% detect where peak ends 
	if [XvPeaksBinary(i-1),XvPeaksBinary(i)] == [1,0]
		% plot vertical line of peakmax
		if plotme
			if strcmp(direction,'Xv')
				plot([XvHistMaxPeakIdx,XvHistMaxPeakIdx],[0,Dataset.ImReader.imHeight],'g--','LineWidth',2);
			elseif strcmp(direction,'Yh')
				plot([0,Dataset.ImReader.imWidth],[XvHistMaxPeakIdx,XvHistMaxPeakIdx],'r--','LineWidth',2);
			else
				error('direction incorrect');
			end
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
