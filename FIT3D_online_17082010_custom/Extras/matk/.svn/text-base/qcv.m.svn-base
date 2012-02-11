%
% ** qcv(v) **
% Returns the unit quaternion corresponding to the given rotation vector.
% - v is a 3d rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function q = qcv(v)
epsilon = 1e-16;
vn = norm(v(1:3));
if vn > epsilon
  q = [cos(vn/2);
       sin(vn/2)*v/vn];
else
  q = [1; 1/2*v];
end
