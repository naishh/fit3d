%
% ** uc123(R) **
% Returns the vector of (1,2,3) Euler angles corresponding to the given
% rotation matrix, R.
% - R is a rotation matrix
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function u = uc123(R)
u = ucijk([1 2 3],R);