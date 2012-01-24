%
% ** Gmv(v) **
% Returns dqv/dv, the Jacobian of the function, qv(v), which maps a
% rotation vector to a unit quaternion.
% - v is the rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function G = Gmv(v)
epsilon = 1e-16;
vn = norm(v);
if vn > epsilon
    svn2 = sin(vn/2);
    a = cos(vn/2)*vn -2*svn2;
    G = svn2/(2*vn)*[-v';2*eye(3)]+a/(2*vn^3)*[zeros(1,3);v*v'];
else
    G = 1/4*[-v';2*eye(3)];
end
