%
% ** dGmv_dvi(i,v) **
% Returns dGv/dvi = d/dvi (dqv/dv).
% - i is the index of the element of v with respect to which we
%   differentiate.
% - v is the rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dG_dv = dGmv_dvi(i,v)
epsilon = 1e-16;
vn = norm(v);
if vn > epsilon
  a = cos(vn/2)*vn -2*sin(vn/2);
  b = -sin(vn/2)*vn^2 - 6*cos(vn/2)*vn + 12*sin(vn/2);
  dG_dv = ...
      -sin(vn/2)/(2*vn)*[ech3i(i)'; zeros(3,3)] + ...
      a/(4*vn^3)*[-v(i)*v';2*(ech3i(i)*v'+v*ech3i(i)'+v(i)*eye(3))] ...
      +v(i)*b/(4*vn^5)*[zeros(1,3);v*v'];
else
  dG_dv = [-1/4*ech3i(i)';zeros(3,3)];
end

