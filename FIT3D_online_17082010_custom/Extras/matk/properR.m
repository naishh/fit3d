function rot_out = properR(rot_in),
% CONVERT2PROPER_DCM
%
%   Converts the 3 by 3 input matrix to a proper rotation matrix.
%
%   Usage: rot_out = convert2proper_dcm(rot_in);
%       rot_in..............3 by 3 input matrix.
%   
%   Returns: rot_out........3 by 3 output matrix.
%

if(nargin~=1)
    error('please provide a 3 by 3 input matrix');
end;

if(size(rot_in)~=[3 3])
    % Try to convert other orientation reprentation to rotation matrix.
    rot_out = convert_rotation(rot_in, 'dcm');
elseif(~isR(rot_in)),
    % Try to approximate a proper rotation matrix.
    [U,S,V] = svd(rot_in);
    rot_out = U*V';
else,
    rot_out = rot_in;
end;

return;