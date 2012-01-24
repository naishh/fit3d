%
% ** Wmv(v) **
% Returns the quaternion rates matrix.
% - v is a rotation vector.
%
% Multiplication of this matrix with the time derivative of the
% quaternion parameters yields the angular velocity in global
% coordinates.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function W = Wmv(v)
W = Wmq(qcv(v));
