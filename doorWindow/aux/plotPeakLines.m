function plotPeakLines(Dataset)
hold on;
for i=1:length(Dataset.Hibaap.XvHistMaxPeaks)
	plot([Dataset.Hibaap.XvHistMaxPeaks(i),Dataset.Hibaap.XvHistMaxPeaks(i)],[0,Dataset.imHeight],'b--','LineWidth',2);
end
for j=1:length(Dataset.Hibaap.YhHistMaxPeaks)
	plot([0,Dataset.imWidth],[Dataset.Hibaap.YhHistMaxPeaks(j),Dataset.Hibaap.YhHistMaxPeaks(j)],'b--','LineWidth',2);
end
