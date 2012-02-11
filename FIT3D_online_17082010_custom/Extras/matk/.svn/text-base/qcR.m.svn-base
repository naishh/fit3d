%
% ** qcR(R) **
% Returns a quaternion that corresponds to the rotation matrix, R.
% - R is a rotation matrix.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function q = qcR(R)
c = [1 + R(1,1) + R(2,2) + R(3,3);
     1 + R(1,1) - R(2,2) - R(3,3);
     1 - R(1,1) + R(2,2) - R(3,3);
     1 - R(1,1) - R(2,2) + R(3,3)];
i = find(c == max(c));
i = i(1)-1;
q = qcRi(i,R);