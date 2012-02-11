%
% ** Vmv(v) **
% Returns the rotation vector rates matrix.
% - v is a rotation vector.
%
% Multiplication of this matrix with the time derivative of the
% rotation vector yields the angular velocity in global coordinates.
% That is, omega = Vmv(v)*(dv/dt)
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function V = Vmv(v)
V = Wmv(v)*Gmv(v);