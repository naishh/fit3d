function q_out = properq(q_in),
% CONVERT2PROPER_QUATERNION
%
%   Converts the four dimensional input vector to a proper unit quaternion.
%
%   Usage: q_out = convert2proper_quaternion(q_in),
%       q_in.................input vector
%       q_out................output quaternion.
%




q = q_in/qsnorm(q_in);

angle = asq(q);

% No rotations with a angle > 179,9999 !
if(abs(rad2deg(angle)) > (180.0-10*eps)),
    q = -q;
end;
     
angle = asq(q ); 
     
if(abs(rad2deg(angle)) > 90.0),
    q = qcinv(q);
end;


q_out = q;

return;