function plotcCorners(Houghlines, HoughlinesRot)
for i=1:length(Houghlines)
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		plotcCorner(cCorner);
	end
end
