%
% ** dRmijk_dal(ijk,l,a) **
% Returns the derivative of the rotation matrix arising from the ijk
% sequence of coordinate rotations with respect to the lth parameter
% of a.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - l is the index of the element of a with respect to which we
%   are taking the derivative.
% - a is a 3d vector of the angles used in the rotation sequence.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dR_da = dRmijk_dal(ijk,l,a)

if l == 1
  dR_da = dRmi_da(ijk(1),a(1))*Rmi(ijk(2),a(2))*Rmi(ijk(3),a(3));
elseif l == 2
  dR_da = Rmi(ijk(1),a(1))*dRmi_da(ijk(2),a(2))*Rmi(ijk(3),a(3));
elseif l == 3
  dR_da = Rmi(ijk(1),a(1))*Rmi(ijk(2),a(2))*dRmi_da(ijk(3),a(3));
else
  disp('Error, second arg must be 1, 2, or 3.');
end
