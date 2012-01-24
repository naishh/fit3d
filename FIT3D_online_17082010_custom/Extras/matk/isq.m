function bool = isq(q)
% IS_UNIT_QUATERNION
%
%   Checks if a vector is a unit quaternion.
%
%   Usage:  bool = is_unit_quaternion(q)
%       q.................unit quaternion
%
%   Returns: 1 if q is an unit quaternion.
%

if(nargin~=1)
    error('please provide a quaterion vector as input');
end;

bool = 0;

if(size(q,1)==4 & size(q,2)==1)% & abs(norm(q)-1.0) < 10*eps & abs(rad2deg(asq(q))) < (180 - 100*eps))
    bool = 1;
end;


return;