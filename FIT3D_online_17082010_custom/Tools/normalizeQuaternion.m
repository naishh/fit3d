% normalizeQuaternion- Normalize a quaternion
%
%
%
% Input  - Q    -> (1x4) Quaternion
%
% Output - Qn    -> (1x4) Normalized quaternion
%          
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function Qn = normalizeQuaternion(Q)

    p1 = Q(1);
    p2 = Q(2);
    p3 = Q(3);
    p4 = Q(4);

    mag=sqrt(p1^2 + p2^2 + p3^2 + p4^2);
    if(p1<0), mag=-mag; end;
    p2=p2/mag;
    p3=p3/mag;
    p4=p4/mag;
    
    Qn = [p2;p3;p4];
