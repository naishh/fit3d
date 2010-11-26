function dist = distPointToLineSegment(p3, p1, p2)
	% p3 is the point
	% p1 and p2 span the line
	

	% calculate unit vector in direction of p2 p1
	p2p1U = (p2-p1)/norm(p2-p1);

	% p3proj is the projection of p3 on line p1p2
	p3proj = dot(p2p1U,(p3-p1)) * p2p1U

	% line from p3 to p3proj
	p3TOp3proj = p3-p3proj;

	p3-p1
	p2-p1
	dot(p3-p2, p2-p1) % projected point is on line segment
	dot(p3-p1, p1) % projected point is on line segment
	if(dot(p3TOp3proj, p2p1U)<0.00001) % projected point is on line segment
		% formula from wolfram
		% todo figure out how to calculate without rounding error
		dist = cross((p3-p1),(p3-p2)) / norm(p2-p1);
	end;

