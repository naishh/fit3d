% fromEuler2Rotation - Obtains the rotation matrix given the euler angles
%
%
% The rotation matrix is computed as a multiplication of 3 rotation
% matrices around the 3 principal axis.
%
%
% Input  - ang   -> (3x1) euler angles
%
% Output - R     -> (3x3) rotation matrix
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function R = fromEuler2Rotation(ang)

    sa = sin(ang(2)); ca = cos(ang(2));
    sb = sin(ang(1)); cb = cos(ang(1));
    sc = sin(ang(3)); cc = cos(ang(3));

    ra = [  ca,  sa,  0; 
           -sa,  ca,  0; 
             0,   0,  1];
    rb = [  cb,  0,  sb; 
             0,  1,  0; 
           -sb,  0,  cb];
    rc = [  1,   0,   0; 
            0,   cc, sc;
            0,  -sc, cc];
    R = rc*rb*ra; 
