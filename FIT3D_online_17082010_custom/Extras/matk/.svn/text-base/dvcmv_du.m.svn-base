%
% ** dvcmv_du(v,u) **
% Returns the derivative of the function that multiplies two
% rotation vectors with respect to the second of the two rotation
% vectors in the product.  That is, if vcmv(v,u) = v*u, then this
% function returns d(v*u)/du.
% - v is the first rotation vector in the product.
% - u is the second rotation vector in the product. 
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function dvm_du = dvcmv_du(v,u)
qv = qcv(v);
qu = qcv(u);
qm = qcmq(qv,qu);
dvm_du = Hmq(qm)*Qmq(qu)*Gmv(u);
