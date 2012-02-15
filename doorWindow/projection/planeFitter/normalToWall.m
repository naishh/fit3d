% given a normal it creates a plane of the normal and move plane to pointcloud 
% input 
% n - 3x1 input
% t - translation vector
% output 1x12 matrix consisting of  4 xyz coords (the wall corner points)
function wall = normalToWall(n1,t, plotme)

	Rz = [	cos(90) -sin(90) 0;...
			sin(90)  cos(90) 0;...
			0			0	 1]
	% rotate
	n2 = (n1'*Rz)'

	n3 = (cross(n1,n2))
	n23=n2+n3

	% translate
	n1 = n1 + t
	n2 = n2 + t
	n3 = n3 + t
	n23 = n23 + t

	%blow it up
	%incrFactor = 10
	%t=t*incrFactor
	%n1 = n1 * incrFactor
	%n2 = n2 * incrFactor
	%n3 = n3 * incrFactor
	%n23 = n23 * incrFactor

	if plotme 
		plotVector3Colored(t, n1, 'k-');
		plotVector3Colored(t, n2, 'r-');
		plotVector3Colored(t, n3, 'g-');
		plotVector3Colored(t, n23, 'y-');
	end

	% construction of wall
	% n3--- n23
	% |	   |
	% 0-----n2

	% order: start with rightbottom and clockwise
	% n2 0 n3 n23
	wall = [ n2(1), n2(2), n2(3),n23(1), n23(2), n23(3), t(1), t(2), t(3), n3(1), n3(2), n3(3)]
end
