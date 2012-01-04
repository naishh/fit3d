function [dist, crossing] = distPointToLineSegment2d(p3, p1, p2)
	p3 = [p3(1);p3(2);0];
	p1 = [p1(1);p1(2);0];
	p2 = [p2(1);p2(2);0];
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
		% for details of formula below see
		% http://mathworld.wolfram.com/Point-LineDistance3-Dimensional.html
		dist = sqrt( sum((cross((p3-p1),(p3-p2)) / norm(p2-p1)).^2));
	elseif (dotp1<0) % closest to point p1
		%disp('angle p1 obtuse so p1 is closest');
		dist = euclideanDist(p3,p1);
		%lineToObj('inpolygon.obj',p3,p1,'red');
	else % closest to point p2
		%disp('else so p2 is obtuse p2 is closest');
		% calc euclidean distance
		dist = euclideanDist(p3,p2);
		%lineToObj('inpolygon.obj',p3,p2,'red');
	end


	dist = abs(dist);
	
	t = -dot((p1-p3),(p2-p1)) / norm(p2-p1)^2;
	crossing = p1 + t*(p2-p1);
	crossing = [crossing(1);crossing(2)];

	% see fit3d_report/papers/websites/Distance between....
	% Ax = p1(1);
	% Ay = p1(2);
	% Bx = p2(1);
	% By = p2(2);
	% Cx = p3(1);
	% Cy = p3(2);

	% L = sqrt( (Bx-Ax)^2 + (By-Ay)^2 );
	% r = ((Cx-Ax)*(Bx-Ax) + (Cy-Ay)*(By-Ay)) / L^2
	% Px = Ax + r*(Bx-Ax);
	% Py = Ay + r*(By-Ay);
	% crossing = [Px;Py];


