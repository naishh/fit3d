%filters the houghlines 
function Houghlines = filtercCorner(Houghlines)

% loop through vertical houghlines
for i=1:length(Houghlines)
	fprintf('%d percent done ', i/length(Houghlines)*100);
	for k=1:length(Houghlines(i).cCorners)
		%cCorner.vlineOri 		 = [p1,p2];
		%cCorner.hlineOri 		 = [p3,p4];
		%cCorner.vlineTjointEnd   = line1End; 
		%cCorner.hlineTjointEnd   = line2End; 
		%cCorner.crossing         = crossing;
		%cCorner.windowMidpointX	 = round((line2End(1)+ crossing(1))/2);
		%cCorner.windowMidpointY	 = round((line1End(2)+ crossing(2))/2);
		%cCorner.dist         	 = dist;
		cCorner = Houghlines(i).cCorners(k);

		% search for other cCorners that are to small
		for i2=1:length(Houghlines)
			for k2=1:length(Houghlines(i2).cCorners)
				cCorner2 = Houghlines(i2).cCorners(k2);
				%order coords
				if cCorner.hlineTjointEnd(1) < cCorner.crossing(1)
					c1x1 = cCorner.hlineTjointEnd(1);
					c1x2 = cCorner.crossing(1);
				else 
					c1x2 = cCorner.hlineTjointEnd(1);
					c1x1 = cCorner.crossing(1);
				end
				if cCorner2.hlineTjointEnd(1) < cCorner2.crossing(1)
					c2x1 = cCorner2.hlineTjointEnd(1);
					c2x2 = cCorner2.crossing(1);
				else 
					c2x2 = cCorner2.hlineTjointEnd(1);
					c2x1 = cCorner2.crossing(1);
				end

				%	c1x1             c1x2
				%	     c2x1 c2x2
				%if points lies in between
				if c2x1>c1x1 && c2x1<c1x2 && c2x2>c2x2 && c2x2<c1x2
					disp('included');
					Houghlines(i2).cCorners(k2).bIncluded = true
					% optimalization is to remove the cCorner directly 
				end
				% todo also for vertical line
			end
		end
	end
end

