%
% ** qsnorm(q) **
% Returns the norm of the quaternion, q.
% - q is a quaternion.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function qn = qsnorm(q)
qn = sqrt(q(1)^2 + q(2)^2 + q(3)^2 + q(4)^2);