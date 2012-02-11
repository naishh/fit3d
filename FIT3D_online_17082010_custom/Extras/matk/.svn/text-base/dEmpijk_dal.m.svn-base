%
% ** dEmpijk_dal(ijk,l,a) **
% Returns the derivative of Empijk(ijk,a) with respect to the lth
% element of a.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - l is the index of the element of a with respect to which we
%   are taking the derivative.
% - a is a 3d vector of the angles used in the rotation sequence.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dEp_da = dEmpijk_dal(ijk,l,a)
if l == 1
  dEp_da = [zeros(3,1)...
	    dRmi_da(ijk(1),a(1))*ech3i(ijk(2)) ...
	    dRmi_da(ijk(1),a(1))*Rmi(ijk(2),a(2))*ech3i(ijk(3))];
elseif l == 2
  dEp_da = [zeros(3,2)...
	    Rmi(ijk(1),a(1))*dRmi_da(ijk(2),a(2))*ech3i(ijk(3))];
elseif l == 3
  dEp_da = zeros(3,3);
else
  disp('Error, second arg must be 1, 2, or 3.');
end
