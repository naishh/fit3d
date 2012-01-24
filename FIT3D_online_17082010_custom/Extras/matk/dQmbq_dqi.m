%
% ** dQmbq_dqi(i) **
% Returns the derivative of the conjugate quaternion matrix with
% respect to the ith element of a unit quaternion.
% - i is the index of the element of the quaternion with respect to
%   which the derivative is to be performed.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dQb_dq = dQmbq_dqi(i)
if i == 0
  dQb_dq = [1, 0, 0, 0;
	   0, 1, 0, 0;
	   0, 0, 1, 0;
	   0, 0, 0, 1];
  return;
end
if i == 1
  dQb_dq = [0, -1,  0,  0;
	   1,  0,  0,  0;
	   0,  0,  0, -1;
	   0,  0,  1,  0];
  return;
end
if i == 2
  dQb_dq = [0,  0, -1,  0;
	   0,  0,  0,  1;
	   1,  0,  0,  0;
	   0, -1,  0,  0];
  return;
end
if i == 3
  dQb_dq = [0,  0,  0, -1;
	   0,  0, -1,  0;
	   0,  1,  0,  0;
	   1,  0,  0,  0];
  return;
end
disp('Error, index must be 0, 1, 2, or 3.');
