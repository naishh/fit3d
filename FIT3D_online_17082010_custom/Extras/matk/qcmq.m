%
% ** qcmq(q,p) **
% Returns the quaternion product, q*p.
% - q is the first unit quaternion of the product.
% - p is the second unit quaternion of the product.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function q = qcmq(q,p)
q = [q(1)*p(1) - dot(q(2:4),p(2:4));
     q(1)*p(2:4) + p(1)*q(2:4) - cross(q(2:4),p(2:4))];