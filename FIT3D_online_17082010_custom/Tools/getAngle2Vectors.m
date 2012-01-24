% getAngle2Vectors - Computes the angle between two 2D or 3D vectors. The
% result is given in degrees.
%
%
%
%
% Input  - V1   -> (3x1) | (2x1) Vector 1 (2D or 3D)
%        - V2   -> (3x1) | (2x1) Vector 2 (2D or 3D)
%       
% Output - ang  -> (1x1) Angle between vectors
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function ang = getAngle2Vectors(V1,V2)

    cosA = dot(V1,V2)/(norm(V1)*norm(V2)); 
    ang = rad2grad(acos(cosA));
