%
% ** dEmijk_dal(ijk,l,a) **
% Returns the derivative of Emijk(ijk,a) with respect to the lth
% element of a.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - l is the index of the element of a with respect to which we
%   are taking the derivative.
% - a is a 3d vector of the angles used in the rotation sequence.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dE_da = dEmijk_dal(ijk,l,a)
if l == 1
  dE_da = zeros(3,3);
elseif l == 2
  dE_da = [(ech3i(ijk(1))'*dRmi_da(ijk(2),a(2))*Rmi(ijk(3),a(3)))'...
	   zeros(3,2)];
elseif l == 3
  dE_da = [(ech3i(ijk(1))'*Rmi(ijk(2),a(2))*dRmi_da(ijk(3),a(3)))'...
	   (ech3i(ijk(2))'*dRmi_da(ijk(3),a(3)))' zeros(3,1)];
else
  disp('Error, second arg must be 1, 2, or 3.');
end
