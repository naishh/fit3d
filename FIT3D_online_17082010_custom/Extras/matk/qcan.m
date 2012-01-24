%
% ** qcan(a,n) **
% Returns the unit quaternion arising from a rotation about the
% unit vector n by an angle a.
% - a is the angle of rotation.
% - n is the unit vector representing the axis of rotation.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function q = qcan(a,n)
q = [cos(a/2);
     sin(a/2)*n];