%
% ** dWmpq_dqi(i) **
% Returns the derivative of the conjugate quaternion rates matrix,
% Wmpq(q), with respect to the ith element of the unit quaternion, q.
% - i is the index of the element of the quaternion with respect to
% which the derivative is to be performed.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dWp_dq = dWmpq_dqi(i)
if i == 0
  dWp_dq = [0, 1, 0, 0;
	    0, 0, 1, 0;
	    0, 0, 0, 1];
  return;
end
if i == 1
  dWp_dq = [-1,  0,  0,  0;
	    0,  0,  0,  1;
	    0,  0, -1,  0];
  return;
end
if i == 2
  dWp_dq = [0,  0,  0, -1;
	    -1,  0,  0,  0;
	    0,  1,  0,  0];
  return;
end
if i == 3
  dWp_dq = [0,  0,  1,  0;
	    0, -1,  0,  0;
	    -1,  0,  0,  0];
  return;
end

disp('Error, index must be 0, 1, 2, or 3.');
