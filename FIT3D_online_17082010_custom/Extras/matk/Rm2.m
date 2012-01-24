%
% ** Rm2(a) **
% Returns the rotation matrix effecting a rotation about the y-axis of
% magnitude a.
% - a is the angle of rotation.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function R = Rm2(a)
R = [cos(a) 0 -sin(a); 
     0      1  0     ; 
     sin(a) 0  cos(a)];