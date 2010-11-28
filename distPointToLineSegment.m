function dist = distPointToLineSegment(p3, p1, p2)
	% p3 is the point
	% p1 and p2 span the line
	
	% calculate unit vector in direction of p2 p1
	%p2p1U = (p2-p1)/norm(p2-p1)

	% p3proj is the projection of p3 on line p1p2
	%p3proj = dot(p2p1U,(p3-p1)) * p2p1U

	p1p2 = p2-p1;
	p2p1 = p1-p2;
	p1p3 = p3-p1;
	p2p3 = p3-p2;
	
	dotp1 = dot(p1p2, p1p3);
	dotp2 = dot(p2p1, p2p3);
	if (dotp1>=0 && dotp2>=0) % both angels are acute so point lies on line segment
		%disp('both angles acute point lies on line segment');
		dist = sum(cross((p3-p1),(p3-p2)) / norm(p2-p1));
	elseif (dotp1<0) % closest to point p1
		%disp('angle p1 obtuse so p1 is closest');
		dist = euclideanDist(p3,p1);
	else % closest to point p2
		%disp('else so p2 is obtuse p2 is closest');
		% calc euclidean distance
		dist = euclideanDist(p3,p2);
	end
	dist = abs(dist);

