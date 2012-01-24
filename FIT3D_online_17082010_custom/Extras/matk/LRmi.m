%
% ** LRmi(i,a) **
% Returns the linearized rotation matrix effecting a rotation about
% the ith-axis of magnitude a.
% - i is the axis about which the rotation is performed.
% - a is the angle of rotation.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function LR = LRmi(i,a)
if i == 1
  LR = LRm1(a);
elseif i == 2
  LR = LRm2(a);
elseif i == 3
  LR = LRm3(a);
else
  disp('Error, first arg must be 1, 2, or 3.');
end