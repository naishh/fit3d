%
% ** Rmijk(ijk,a) **
% Returns the rotation matrix arising from the ijk sequence of
% coordinate rotations.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - a is a 3d vector of the angles used in the rotation sequence.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function R = Rmijk(ijk,a)
R = Rmi(ijk(1),a(1))*Rmi(ijk(2),a(2))*Rmi(ijk(3),a(3));