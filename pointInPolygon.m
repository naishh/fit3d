function r = pointInPolygon(isp, c1, c2, c3, c4)
	% the idea of this function is that if a point lies within a polygon
	% that the summed angles of all vectors from that point to the polygon cornerpoints should sum op to 360 degrees (2 pi)

	% normalise
	isp = isp / norm(isp);
	c1 = c1/norm(c1);
	c2 = c2/norm(c2);
	c3 = c3/norm(c3);
	c4 = c4/norm(c4);
	
	% define relative from isp
	c1 = c1 - isp;
	c2 = c2 - isp;
	c3 = c3 - isp;
	c4 = c4 - isp;

	% define angels from intersectionpoint to c1
	a1 = acos(dot(c1, c2));
	a2 = acos(dot(c2, c3));
	a3 = acos(dot(c3, c4));
	a4 = acos(dot(c4, c1));

	r = a1+a2+a3+a4;
	if abs(r - 2*pi) < 0.1
		r = true;
	else 
		r = false;
	end
