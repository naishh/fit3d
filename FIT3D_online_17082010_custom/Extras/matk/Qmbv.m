%
% ** Qmbv(v) **
% Returns the conjugate quaternion matrix.
% - v is a rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function Qb = Qmbv(v)
Qb = Qmbq(qcv(v));
