%
% ** Wmpv(v) **
% Returns the conjugate quaternion rates matrix.
% - v is a rotation vector.
%
% Multiplication of this matrix with the time derivative of the
% quaternion parameters yields the angular velocity in body-fixed
% coordinates.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function Wp = Wmpv(v)
Wp = Wmpq(qcv(v));
