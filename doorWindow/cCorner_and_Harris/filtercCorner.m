%filters the houghlines 
function Houghlines = filtercCorner(Houghlines)

% loop through vertical houghlines
for i=1:length(Houghlines)
	fprintf('%d percent done \n', i/length(Houghlines)*100);
	for k=1:length(Houghlines(i).cCorners)
		cCorner = Houghlines(i).cCorners(k);
		%clf;
		%plotcCorner(cCorner, 'cCornerBlack',false);
		%hold on;

		% search for other cCorners that are to small
		for i2=1:length(Houghlines)
			for k2=1:length(Houghlines(i2).cCorners)
				% break loop if searching for another but looking at itself
				if i==i2 && k==k2
					break;
				end
				cCorner2 = Houghlines(i2).cCorners(k2);
				%order horizontal coords
				if cCorner.hlineTjointEnd(1) < cCorner.crossing(1)
					hc1x1 = cCorner.hlineTjointEnd(1);
					hc1x2 = cCorner.crossing(1);
				else 
					hc1x2 = cCorner.hlineTjointEnd(1);
					hc1x1 = cCorner.crossing(1);
				end
				if cCorner2.hlineTjointEnd(1) < cCorner2.crossing(1)
					hc2x1 = cCorner2.hlineTjointEnd(1);
					hc2x2 = cCorner2.crossing(1);
				else 
					hc2x2 = cCorner2.hlineTjointEnd(1);
					hc2x1 = cCorner2.crossing(1);
				end

				%order vertical coords
				if cCorner.vlineTjointEnd(2) < cCorner.crossing(2)
					vc1x1 = cCorner.vlineTjointEnd(2);
					vc1x2 = cCorner.crossing(2);
				else 
					vc1x2 = cCorner.vlineTjointEnd(2);
					vc1x1 = cCorner.crossing(2);
				end
				if cCorner2.vlineTjointEnd(2) < cCorner2.crossing(2)
					vc2x1 = cCorner2.vlineTjointEnd(2);
					vc2x2 = cCorner2.crossing(2);
				else 
					vc2x2 = cCorner2.vlineTjointEnd(2);
					vc2x1 = cCorner2.crossing(2);
				end

				%	c1x1             c1x2
				%	     c2x1 c2x2
				
				% increase line length
				hStretchParam = 0.4;
				vStretchParam = 0.4;
				cCrossingMaxDist = 0.2;

				hVect = hc1x2-hc1x1;
				hExtend = hVect*hStretchParam;
				hc1x1 = hc1x1-hExtend; hc1x2 = hc1x2+hExtend;

				vVect = vc1x2-vc1x1;
				vExtend = vVect*vStretchParam;
				vc1x1 = vc1x1-vExtend; vc1x2 = vc1x2+vExtend;

				if  euclideanDist(cCorner.crossing, cCorner2.crossing) < cCrossingMaxDist* ((vExtend+hExtend)/2)...
				    hc2x1>hc1x1 && hc2x1<hc1x2 && hc2x2>hc2x1 && hc2x2<hc1x2...
					&&  vc2x1>vc1x1 && vc2x1<vc1x2 && vc2x2>vc2x1 && vc2x2<vc1x2
					Houghlines(i2).cCorners(k2).bIncluded = true;
					% optimalization is to remove the cCorner directly 
				end
				% todo also for vertical line
			end
		end
	end
end

