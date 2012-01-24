%
% ** Qmq(q) **
% Returns the quaternion matrix.
% - q is a unit quaternion.
%
% Quaternion mupliplication: q*p = Qmq(q)*p
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function Q = Qmq(q)
Q = [q(1), -q(2:4)';
     q(2:4), q(1)*eye(3)-Cmx(q(2:4))];
