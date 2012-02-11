%
% ** Wmq(q) **
% Returns the quaternion rates matrix.
% - q is a unit quaternion.
%
% Multiplication of this matrix with the time derivative of the
% quaternion parameters yields the angular velocity in global
% coordinates.  That is, omega = Wmq(q)*(dq/dt).
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function W = Wmq(q)
W = [-q(2),  q(1), -q(4),  q(3);
     -q(3),  q(4),  q(1), -q(2);
     -q(4), -q(3),  q(2),  q(1)];