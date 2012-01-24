%
% ** LRm2(a) **
% Returns the linearized rotation matrix effecting a rotation about
% the y-axis of magnitude a.
% - a is the angle of rotation.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function LR = LRm2(a)
LR = [1  0 -a; 
      0  1  0; 
      a  0  1];