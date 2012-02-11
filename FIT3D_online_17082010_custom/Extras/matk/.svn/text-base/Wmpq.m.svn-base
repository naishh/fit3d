%
% ** Wmpq(q) **
% Returns the conjugate quaternion rates matrix.
% - q is a unit quaternion.
%
% Multiplication of this matrix with the time derivative of the
% quaternion parameters yields the angular velocity in body-fixed
% coordinates.  That is, omega' = Wmpq(q)*(dq/dt).
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function Wp = Wmpq(q)
Wp = [-q(2),  q(1),  q(4), -q(3);
      -q(3), -q(4),  q(1),  q(2);
      -q(4),  q(3), -q(2),  q(1)];