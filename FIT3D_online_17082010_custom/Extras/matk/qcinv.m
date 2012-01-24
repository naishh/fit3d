%
% ** qcinv(q) **
% Returns the inverse of the quaternion, q.
% - q is a quaternion.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function qi = qcinv(q)
qi = qcadj(q)/qsnorm(q);