%
% ** vcq(q) **
% Returns the rotation vector corresponding to the given unit quaternion.
% - q is a unit quaternion.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function v = vcq(q)
epsilon = 1e-16;
d = sqrt(1-q(1)^2);
if d > epsilon
  v = 2*acos(q(1))*q(2:4)/d;
else 
  v = 2*q(2:4);
end