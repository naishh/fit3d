%
% ** qcexp(q,t) **
% Returns the quaternion exponent, q^t.
% - q is a quaternion.
% - t is the real-valued exponent.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function qt = qcexp(q,t)
epsilon = 1e-16;
a = 2*acos(q(1));
if a > epsilon
  qt = [cos(t*a/2);
	sin(t*a/2)*q(2:4)/sqrt(1-q(1)^2)];
else
  qt = [cos(t*a/2);
	t*q(2:4)];
end
