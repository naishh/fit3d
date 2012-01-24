function plotHoughline(xy,plotme,colorStr)
hold on;
%if plotme
%	plot(xy(:,1),-xy(:,2),'LineWidth',1,'Color',colorStr);
%end

markerSize = 10;
% Plot beginnings and ends of Houghlines
if plotme
	plot(xy(1,1),-xy(1,2),'x','LineWidth',2,'Color',colorStr,'MarkerSize',markerSize);
	plot(xy(2,1),-xy(2,2),'x','LineWidth',2,'Color',colorStr,'MarkerSize',markerSize);
end

