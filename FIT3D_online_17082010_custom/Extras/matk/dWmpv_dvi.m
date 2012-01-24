%
% ** dWmpv_dvi(i,v) **
% Returns the derivative of the conjugate quaternion rates matrix,
% Wmpv(v), with respect to the ith element of the rotation vector, v.
% - i is the index of the element of the quaternion with respect to
%   which the derivative is to be performed.
% - v is the rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dWp_dv = dWmpv_dvi(i,v)
dWp_dv = Wmpq(gcvi(i,v));