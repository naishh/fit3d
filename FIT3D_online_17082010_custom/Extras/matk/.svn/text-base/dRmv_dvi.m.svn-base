%
% ** dRmv_dvi(i,v) **
% Returns the derivative of the rotation matrix arising from the
% rotation vector v with respect to the ith element of v.
% - v is a rotation vector.
% - i is the index of the element of v with respect to which the 
%   derivative is to be taken
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dR_dv = dRmv_dvi(i,v)
g = gcvi(i,v);
q = qcv(v);
dR_dv = dRmq_dq0(q)*g(1) + ...
    dRmq_dq1(q)*g(2) + ...
    dRmq_dq2(q)*g(3) + ...
    dRmq_dq3(q)*g(4);
