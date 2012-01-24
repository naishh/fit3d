%
% ** ncv(v) **
% Returns the axis of rotation of a rotation vector.
% - v is a rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function n = ncv(v)
n = v/norm(v);