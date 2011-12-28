% calcs the midpoint of a window from a connectedCorner
function Houghlines = cCornerToWindow(Houghlines,HoughlinesRot)
for i=1:length(Houghlines)
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		% if corner has nearby harris
		%if cCorner.harrisEvidence == true
			%if cCorner.HdirectionRight == 0 && cCorner.VdirectionUp == 1
			%if cCorner.shapeType == 'l'

			a = Houghlines(i).point1;
			b = Houghlines(i).point2;
			c = HoughlinesRot(cCorner.HoughlineRotIdx).point1;
			d = HoughlinesRot(cCorner.HoughlineRotIdx).point2;

			% calc midpoint vert line
			xyAvgV = (a + b) / 2;
			% calc midpoint hor line
			xyAvgH = (c + d) / 2;
			% the window is calculated by taking the x of the horizontal line segment and taking the y of the vertical line segment
			yWindow = xyAvgV(2);
			xWindow = xyAvgH(1);

			xyWindow= [xWindow;yWindow];

			Houghlines(i).cCorners(k).xyWindow = [xWindow, yWindow];
			% plot middlepoint of window
			plot(xWindow, -yWindow, '+r');

			% TODO how to deal with multiple window on same location
			% TODO faster: make array of window idx'es
			%Window{xWindow,yWindow}.Height  = h;
			%Window{xWindow,yWindow}.Width   = w;

			h = abs(a(2) - b(2));
			w = abs(c(1) - d(1));
			plotWindow(xWindow,yWindow,h,w)
		%end

	end
end
