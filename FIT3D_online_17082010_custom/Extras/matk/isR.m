function bool = isR(rot),
% IS_DCM
%
%   Check if a matrix is a rotation matrix.
%
%   Usage:  bool = is_dcm(rot),
%       rot............rotation matrix
%   
%   Returns: 1.........if rot is a rotation matrix, otherwise 0.
%

if(nargin~=1)
    error('please provide a rotation matrix (dcm) as input');
end;

bool = 0;

if(size(rot)==[3 3] & abs(abs(det(rot))-1.0) < 10000*eps)
    bool=1;
end;

return;