%
% ** gcvi(i,v) **
% Returns dqv/dvi, the derivative of the function, qv(v), which maps a
% rotation vector to a unit quaternion, with respect to the ith element 
% of v.
% - i is the index of the element of the rotation vector with respect
%   to which the derivative is to be performed.
% - v is the rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function gi = gcvi(i,v)
epsilon = 1e-16;
vn = norm(v);
if vn > epsilon
  a = cos(vn/2)*vn -2*sin(vn/2);
  gi = sin(vn/2)/(2*vn)*[-v(i);2*ech3i(i)]+a/(2*vn^3)*[0;v(i)*v];
else
  gi = 1/4*[-v(i);2*ech3i(i)];
end
