function plotHoughline(xy,plotme,colorStr)
if plotme
	plot(xy(:,1),xy(:,2),'LineWidth',2,'Color',colorStr);
end

% % Plot beginnings and ends of Houghlines
% if plotme
% 	plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
% 	plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% end

