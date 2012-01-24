%
% ** LRm1(a) **
% Returns the linearized rotation matrix effecting a rotation about
% the x-axis of magnitude a.
% - a is the angle of rotation.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function LR = LRm1(a)
LR = [1  0  0; 
      0  1  a; 
      0 -a  1];