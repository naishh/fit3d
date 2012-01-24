%
% ** Rm3(a) **
% Returns the rotation matrix effecting a rotation about the z-axis of
% magnitude a.
% - a is the angle of rotation.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function R = Rm3(a)
R = [cos(a)  sin(a) 0; 
     -sin(a) cos(a) 0; 
     0       0      1];