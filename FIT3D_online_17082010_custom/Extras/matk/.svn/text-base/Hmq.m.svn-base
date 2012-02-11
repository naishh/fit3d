%
% ** Hmq(q) **
% Returns dvq/dq, the Jacobian of the function vq(q), which maps a
% unit quaternion to a rotation vector.
% - q is the unit quaternion.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function H = Hmq(q)
epsilon = 1e-16;
if (1 - q(1)) > epsilon
  c = 1/(1 - q(1)^2);
  d = acos(q(1))*sqrt(c);
  H = 2*[c*d*q(1)*q(2)-c*q(2), d, 0, 0;
	 c*d*q(1)*q(3)-c*q(3), 0, d, 0;
	 c*d*q(1)*q(4)-c*q(4), 0, 0, d];
else
  H = 2*[0, 1, 0, 0;
	 0, 0, 1, 0;
	 0, 0, 0, 1];
end