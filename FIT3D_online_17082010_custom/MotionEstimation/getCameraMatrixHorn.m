% getCameraMatrixHorn - Given an essential matrix, compute the
% corresponding camera matrix based on Horn (1990) paper 
% (baseline and orientation)
%
%
% Given the essential matrix, it is decomposed and 4 possible camera
% matrices are calculated. This method is apparently more stable than the
% one presented by Zisserman.
%
%
% Input  - E     -> (3x3) essential matrix
%
% Output - PXcam -> (3x4x4) Camera matrices (rotation and translation)
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [PXcam] = getCameraMatrixHorn(E)

    % Obtain bxbT
    bbt = 0.5*trace(E*E')*eye(3,3)-E*E';
        
    % We obtain b by selecting the largest row and dividing by the square
    % root of the diagonal. This is for numerical accuracy.
    if (bbt(1,1)>=bbt(2,2) && bbt(1,1)>=bbt(3,3))
        b1 = bbt(1,:)'./sqrt(bbt(1,1));
    elseif (bbt(2,2)>=bbt(1,1) && bbt(2,2)>=bbt(3,3))
        b1 = bbt(2,:)'./sqrt(bbt(2,2));
    elseif (bbt(3,3)>=bbt(1,1) && bbt(3,3)>=bbt(2,2))
        b1 = bbt(3,:)'./sqrt(bbt(3,3));
    end;
    b2 = -b1;
    
    % Compute cofactors of E
    cofE = [cross(E(:,2),E(:,3)),cross(E(:,3),E(:,1)),cross(E(:,1),E(:,2))]';
    
    % Compute two matricex B
    B1 = [ 0      , -b1(3) ,  b1(2);
           b1(3)  ,  0     , -b1(1);
          -b1(2)  ,  b1(1) ,  0    ];
      
    B2 = [ 0      , -b2(3) ,  b2(2);
           b2(3)  ,  0     , -b2(1);
          -b2(2)  ,  b2(1) ,  0    ];

    b1dot = dot(b1,b1);
    b2dot = dot(b2,b2);
      
    % Compute both R
    R1 = inv(b1dot)*(cofE'-B1*E);
    R2 = inv(b2dot)*(cofE'-B2*E);
    
    % Scale baseline
    b1 = b1./max(abs(b1));
    b2 = b2./max(abs(b2));
    
    % Build 4 possible solutions
    PXcam = zeros(3,4,4);
    PXcam(:,:,1) = [R1,b1];
    PXcam(:,:,2) = [R1,b2];
    PXcam(:,:,3) = [R2,b1];
    PXcam(:,:,4) = [R2,b2];
