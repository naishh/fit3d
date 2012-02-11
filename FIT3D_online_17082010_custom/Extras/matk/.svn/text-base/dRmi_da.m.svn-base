%
% ** dRmi_da(i,a) **
% Returns the derivative of the coordinate rotation matrix, Rmi(a),
% with respect to the angle a.
% - a is the angle of rotation.
% - i is the index of the element of a with respect to which the 
%   derivative is to be taken
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dR_da = dRmi_da(i,a)
if i == 1
  dR_da = dRm1_da(a);
elseif i == 2
  dR_da = dRm2_da(a);
elseif i == 3
  dR_da = dRm3_da(a);
else
  disp('Error, first arg must be 1, 2, or 3.');
end
