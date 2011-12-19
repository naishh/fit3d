function plotHoughlineShort(Houghline,plotme,colorStr)
xy = [Houghline.point1; Houghline.point2];
if plotme
	plot(xy(:,1),-xy(:,2),'LineWidth',2,'Color',colorStr);
end

