function Houghlines = cCornerAddHarrisEvidence(Houghlines, cornerScaleAccu, scale, cCornerHarrisThreshold)
for i=1:length(Houghlines)
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		harrisCrossingNearby = false;
		Houghlines(i).cCorners(k).harrisEvidenceDists  = [];
		Houghlines(i).cCorners(k).harrisCorners  = [];
		% loop through harris' corner featerus
		for j=1:length(cornerScaleAccu(scale).Corners)
			% get crossings
			v1 = cCorner.crossing; 
			v2 = cornerScaleAccu(scale).Corners(j,:)';
			% calc inter crossing dist
			d = euclideanDist(v1,v2);
			% if crossing is nearby
			if d<cCornerHarrisThreshold;
				harrisCrossingNearby = true;
				Houghlines(i).cCorners(k).harrisEvidence = true;
				% should collect all distances d for every j
				Houghlines(i).cCorners(k).harrisEvidenceDists = [Houghlines(i).cCorners(k).harrisEvidenceDists,d];
				Houghlines(i).cCorners(k).harrisCorners = [Houghlines(i).cCorners(k).harrisCorners, v2];
			end
			if harrisCrossingNearby == false
				Houghlines(i).cCorners(k).harrisEvidence = false;
			end
		end
	end
end
