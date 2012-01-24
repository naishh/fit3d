function bool = isEuler(v)
% IS_ROT_VECTOR
%
%   Checks if a vector is a rotation vector
%
%   Usage:  bool = is_rot_vector(v)
%               v......rotation vector.
%   
%   Returns: 1 if v is a rotation vector.
%

if(nargin~=1)
    error('please provide [heading pitch yaw] as input');
end;

bool = 0;

if( size(v,1)==1 && size(v,2)==3 )
    bool = 1;
end;


return;