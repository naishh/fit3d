%
% ** vcR(R) **
% Returns the rotation vector corresponding to the given rotation matrix.
% - R is a rotation matrix.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function v = vcR(R)
v = vcq(qcR(R));