%
% ** dRm1_da(a) **
% Returns the derivative of the coordinate rotation matrix Rm1(a)
% with respect to the angle a.
% - a is the angle of rotation.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dR_da = dRm1_da(a)
dR_da = [0,       0,       0;
     0, -sin(a),  cos(a);
     0, -cos(a), -sin(a)];