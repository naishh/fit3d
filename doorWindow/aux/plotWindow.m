		function plotWindow(xWindow,yWindow,h,w)
			% plot window 
			y1 = yWindow-h;
			y2 = yWindow+h;
			x1 = xWindow-w;
			x2 = xWindow+w;
			X = [x1,x2,x2,x1,x1];
			Y = [y1,y1,y2,y2,y1];
			plot(X,-Y,'-k');
		end
