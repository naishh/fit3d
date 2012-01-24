%
% ** dRm2_da(a) **
% Returns the derivative of the coordinate rotation matrix Rm2(a)
% with respect to the angle a.
% - a is the angle of rotation.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dR_da = dRm2_da(a)
dR_da = [-sin(a), 0, -cos(a);
	 0,       0,       0;
	 cos(a),  0, -sin(a)];
 