% getImagePlaneNormal - Compute the normal of a plane given 3 points of the
% plane
%
%
%
% Input  - P1             -> (3x1) Point 1
%        - P2             -> (3x1) Point 2
%        - P3             -> (3x1) Point 3
%        - Pcam           -> (3x4) Camera matrix
%
% Output - N              -> (3x1) Image normal
%          X2imageplane2  -> (3x1) Point in the plane
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [N,X2imageplane2] = getImagePlaneNormal(P1,P2,P3,Pcam)

    R = Pcam(:,1:3);
    T = Pcam(:,4);

    X1imageplane1 = P1;
    X2imageplane1 = P2;
    X3imageplane1 = P3;

    % Rotate and translate 3 points that are in the plane
    X1imageplane2 = R*X1imageplane1 + T;
    X2imageplane2 = R*X2imageplane1 + T;
    X3imageplane2 = R*X3imageplane1 + T;
    
    
    %X1imageplane2 = X1imageplane1 + T;
    %X2imageplane2 = X2imageplane1 + T;
    %X3imageplane2 = X3imageplane1 + T;


    % Define the coordinates for shortness
    x1 = X1imageplane2(1);
    y1 = X1imageplane2(2);
    z1 = X1imageplane2(3);
    x2 = X2imageplane2(1);
    y2 = X2imageplane2(2);
    z2 = X2imageplane2(3);
    x3 = X3imageplane2(1);
    y3 = X3imageplane2(2);
    z3 = X3imageplane2(3);

    % Then calculate the normal of those 3 points (the second image
    % plane)
    A = y1*(z2-z3)+y2*(z3-z1)+y3*(z1-z2);
    B = z1*(x2-x3)+z2*(x3-x1)+z3*(x1-x2);
    C = x1*(y2-y3)+x2*(y3-y1)+x3*(y1-y2);
    N = [A;B;C];
