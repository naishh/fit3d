%
% ** uc313(R) **
% Returns the vector of (3,1,3) Euler angles corresponding to the given
% rotation matrix, R.
% - R is a rotation matrix
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function u = uc313(R)
u = ucijk([3 1 3],R);