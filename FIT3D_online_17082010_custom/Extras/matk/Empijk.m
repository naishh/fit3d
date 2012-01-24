%
% ** Empijk(ijk,a) **
% Returns the body-fixed Euler angle rates matrix.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - a is a 3d vector of the angles used in the rotation sequence.
%
% Multiplication of this matrix with the vector of Euler angle
% rates (i.e., the time derivative of the Euler angle vector)
% yields the angular velocity in the body-fixed coordinates.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function Ep = Empijk(ijk,a)
Ep = [ech3i(ijk(1)) ...
      Rmi(ijk(1),a(1))*ech3i(ijk(2)) ...
      Rmi(ijk(1),a(1))*Rmi(ijk(2),a(2))*ech3i(ijk(3))];
