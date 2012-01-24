%
% ** qcRi(i,R) **
% Returns the ith quaternion that corresponds to the rotation matrix, R.
% - i is the index of the desired inversion function.
% - R is a rotation matrix.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function q = qcRi(i,R)

if i == 0
  q = qcR0(R);
  return;
end
if i == 1
  q = qcR1(R);
  return;
end
if i == 2
  q = qcR2(R);
  return;
end
if i == 3
  q = qcR3(R);
  return;
end
