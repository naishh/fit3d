function XvHistMaxPeaks = getHistMaxPeaks(Dataset, XvHistSmooth, XvThresh, plotme, direction);
%XvPeaksBinary = XvHistSmooth>=XvThresh;
XvPeaksBinary = XvHistSmooth>=XvThresh*max(XvHistSmooth);
XvHistMaxPeak = intmin;
k=1;
for i=2:length(XvPeaksBinary)
	% detect where peak ends 
	if [XvPeaksBinary(i-1),XvPeaksBinary(i)] == [1,0]
		% plot vertical line of peakmax
		if plotme
			if strcmp(direction,'Xv')
				plot([XvHistMaxPeakIdx,XvHistMaxPeakIdx],[0,Dataset.ImReader.imHeight],'g--','LineWidth',2);
				% quickfix for legenda
				%plot([0,0],[0,0],'k--','LineWidth',2);
				legend('Xh: total amount of horizontal Houghlines that occur in pixelcolumn x',...
				'Xhder: Absolute of derivative of Xh',...
				'Xv: total amount of vertical Houghlines that occur in pixelcolumn x',...
				'Xpseudo: Xhder - Xv',...
				'Xv peaks'...
				);
			elseif strcmp(direction,'XvPseudo')
				plot([XvHistMaxPeakIdx,XvHistMaxPeakIdx],[0,Dataset.ImReader.imHeight],'k--','LineWidth',2);
				legend('Xh: total amount of horizontal Houghlines that occur in pixelcolumn x',...
				'Xhder: Absolute of derivative of Xh',...
				'Xv: total amount of vertical Houghlines that occur in pixelcolumn x',...
				'Xpseudo: Xhder - Xv',...
				'Xv peaks',...
				'Xpseudo peaks'...
				);
			elseif strcmp(direction,'Yh')
				%plot([0,Dataset.ImReader.imWidth],[XvHistMaxPeakIdx,XvHistMaxPeakIdx],'r--','LineWidth',2);
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

