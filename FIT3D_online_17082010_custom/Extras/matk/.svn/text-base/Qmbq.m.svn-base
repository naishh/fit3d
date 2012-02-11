%
% ** Qmbq(q) **
% Returns the conjugate quaternion matrix.
% - q is a unit quaternion.
%
% Quaternion mupliplication: q*p = Qmbq(p)*q
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function Qb = Qmbq(q)
Qb = [q(1), -q(2:4)';
      q(2:4), q(1)*eye(3)+Cmx(q(2:4))];