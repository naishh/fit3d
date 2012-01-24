%
% ** Vmpv(v) **
% Returns the conjugate rotation vector rates matrix.
% - v is a rotation vector.
%
% Multiplication of this matrix with the time derivative of the
% rotation vector yields the angular velocity in body-fixed
% coordinates. That is, omega' = Vmpv(v)*(dv/dt)
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function V = Vmpv(v)
V = Wmpv(v)*Gmv(v);