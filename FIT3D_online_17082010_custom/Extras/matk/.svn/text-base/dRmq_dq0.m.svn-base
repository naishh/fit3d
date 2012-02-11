%
% ** dRmq_dq0(q) **
% Returns the derivative of the rotation matrix arising from the unit
% quaternion q with respect to the 0th element of q.
% - q is a unit quaternion.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dR_dq = dRmq_dq0(q)
dR_dq = 2*[q(1),  q(4), -q(3);
	   -q(4),  q(1),  q(2);
	   q(3), -q(2),  q(1)];