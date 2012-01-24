%
% ** vcmv(v1,v2) **
% Returns the product of two rotation vectors, such that
% Rmv(vcmv(v1,v2)) = Rmv(v1)*Rmv(v2)
% - v1 is a rotation vector.
% - v2 is a rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function v = vcmv(v1,v2)
v = vcq(qcmq(qcv(v1),qcv(v2)));