function Houghlines = cCornerAddShapeType(Houghlines)
for i=1:length(Houghlines)
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		% topleft l type
		if cCorner.HdirectionRight == 0 && cCorner.VdirectionUp == 1
			Houghlines(i).cCorners(k).shapeType = 'l';
		end
		% shapes
		% every corner has a l shape (4x)
		% the 
		...
	end
end
