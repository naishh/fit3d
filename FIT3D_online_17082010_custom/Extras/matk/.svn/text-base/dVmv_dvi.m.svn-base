%
% ** dVmv_dvi(i,v) **
% Returns the derivative of the rotation vector rates matrix with
% respect to the ith element of the rotation vector.
% - i is the index of the element of the rotation vector with respect
%   to which the derivative is to be performed.
% - v is a rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dV_dv = dVmv_dvi(i,v)
dV_dv = dWmv_dvi(i,v)*Gmv(v) + Wmv(v)*dGmv_dvi(i,v);