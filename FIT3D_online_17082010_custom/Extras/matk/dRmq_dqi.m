%
% ** dRmq_dqi(i,q) **
% Returns the derivative of the rotation matrix arising from the unit
% quaternion q with respect to the ith element of q.
% - i is the index of the element of the quaternion with respect
%   to which the derivative is to be performed.
% - q is a unit quaternion.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dR_dq = dRmq_dqi(i,q)
if i == 0
  dR_dq = dRmq_dq0(q);
  return;
end
if i == 1
  dR_dq = dRmq_dq1(q);
  return;
end
if i == 2
  dR_dq = dRmq_dq2(q);
  return;
end
if i == 3
  dR_dq = dRmq_dq3(q);
  return;
end

disp('Error, index must be 0, 1, 2, or 3.');