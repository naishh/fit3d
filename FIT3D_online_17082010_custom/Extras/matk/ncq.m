%
% ** ncq(q) **
% Returns the axis of rotation of a quaternion.
% - q is a unit quaternion.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function n = ncq(q)
n = q(2:4)/sqrt(1-q(1)^2);