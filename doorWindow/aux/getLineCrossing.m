% calculates intersection and checks for parallel lines.  
% returns tjoint adjusted line segments 

% TODO return 2 cCorners if ua or ub <1
function [crossing,dist,line1,line2] = findLineIntersection(p1,p2,p3,p4) 
% calculate differences  
xD1=p2(1)-p1(1);  
xD2=p4(1)-p3(1);  
yD1=p2(2)-p1(2);  
yD2=p4(2)-p3(2);  
xD3=p1(1)-p3(1);  
yD3=p1(2)-p3(2);    

% calculate the lengths of the two lines  
len1=sqrt(xD1*xD1+yD1*yD1);
len2=sqrt(xD2*xD2+yD2*yD2); 

% calculate angle between the two lines.  
dot=(xD1*xD2+yD1*yD2); % dot product  
deg=dot/(len1*len2);  

% if abs(angle)==1 then the lines are parallell,  
% so no intersection is possible  
if(abs(deg)==1)
	error('lines are parallel');
end

% find intersection Pt between two lines  
div=yD2*xD1-xD2*yD1;  
ua=(xD2*yD3-yD2*xD3)/div;
ub=(xD1*yD3-yD1*xD3)/div; 
% calc intersection point:
crossing(1)=p1(1)+ua*xD1;  
crossing(2)=p1(2)+ua*yD1; 
crossing = crossing';

% ua and ub are in [0..1] if crossing lies on the line ua or ub
if (ub>=0 && ub<=1) && (ua>=0 && ua <=1)
	%disp('point lies on both segments');
	line1 = [p1,p2];
	line2 = [p3,p4];
	dist = 0;
else
	p1crossingDist = euclideanDist(crossing,p1);
	p2crossingDist = euclideanDist(crossing,p2);
	p3crossingDist = euclideanDist(crossing,p3);
	p4crossingDist = euclideanDist(crossing,p4);
	if (ua>=0 && ua <=1)
		%disp('point lies on segment 1');
		% p3 is closest to crossing
		if p3crossingDist<p4crossingDist
			dist = p3crossingDist;
			% make line from oposite of p3 (p4) to crossing
			line1 = [p1,p2];
			line2 = [p4,crossing];
		else
			dist = p4crossingDist;
			line1 = [p1,p2];
			line2 = [p3,crossing];
		end
	end
	if (ub>=0 && ub<=1)
		%disp('point lies on segment 2');
		% p1 is closest to crossing
		if p1crossingDist<p2crossingDist
			dist = p1crossingDist;
			% make line from oposite of p1 (p2) to crossing
			line1 = [p2,crossing];
			line2 = [p3,p4];
		else
			dist = p2crossingDist;
			line1 = [p1,crossing];
			line2 = [p3,p4];
		end
	end
	if ~(ub>=0 && ub<=1) && ~(ua>=0 && ua <=1)
		%disp('point lies outside both segments');
		% add dists of both closest line segment endpoints to crossing
		dist = min(p1crossingDist,p2crossingDist) + min(p3crossingDist,p4crossingDist);
		if p3crossingDist<p4crossingDist
			% make line from oposite of p3 (p4) to crossing
			line2 = [p4,crossing];
		else
			line2 = [p3,crossing];
		end
		if p1crossingDist<p2crossingDist
			line1 = [p2,crossing];
		else
			line1 = [p1,crossing];
		end
	end
end

