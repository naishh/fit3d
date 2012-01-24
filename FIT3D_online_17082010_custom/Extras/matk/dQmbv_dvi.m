%
% ** dQmbv_dvi(i,v) **
% Returns the derivative of the conjugate quaternion matrix with
% respect to the ith element of the rotation vector.
% - i is the index of the element of the rotation vector with respect
%   to which the derivative is to be performed.
% - v is a rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dQb_dv = dQmbv_dvi(i,v)
dQb_dv = Qmbq(gcvi(i,v));
