%
% ** qcaw(a,w) **
% Returns the unit quaternion arising from a rotation about the
% vector w by an angle a.
% - a is the angle of rotation.
% - w is the vector representing the axis of rotation.
%
% This is like qcan(a,n), but in this case the vector w may have a
% norm not equal to one, as it is normalized first.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function q = qcaw(a,w)
wn = sqrt(w(1)^2+w(2)^2+w(3)^2);
n = w;
if wn ~= 1
  n = w/wn;
end
q = [cos(a/2);
     sin(a/2)*n];