% geometricMeanR - Obtains the geometric mean of two rotaions in SO(3) 
%
% Given two rotations, the geometric mean is calculated according to the
% paper from Maher Moakher.
%
%
% Input  - R1    -> Rotation 1
%        - R2    -> Rotation 2
%
% Output - R     -> Geometric mean of rotations R1 and R2 
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function R = geometricMeanR(R1,R2)

R = R2*sqrt(R2'*R2);
