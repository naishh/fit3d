%
% ** vcflip(v) **
% Returns the conjugate rotation vector, corresponding to a rotation about
% the same axis, but in the opposite direction.
% - v is a rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function vf = vcflip(v)
vf = vcq(-qcv(v));