% geometricWeightedMeanR - Obtains the geometric weighted mean of two rotaions in SO(3) 
%
% Given two rotations, the geometric weighted mean is calculated according to the
% paper from Maher Moakher, MEANS AND AVERAGING IN THE GROUP OF ROTATIONS.
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

function R = geometricWeightedMeanR(R1,R2,w1,w2)

r1 = R1;
r2 = R2;

R = expm(-w2*logm(r2'/r1')/(w2+w1))/r1';


