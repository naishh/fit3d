% goldStd2DAffine - Gold Standard Algorithm for Affine 2D homographies
%
%
% Computes the affine homography given two sets of corresponding points. Based on
% the Gold Standard Algorithm described by Zisserman in p130.
%
%
% Input  - A -> 3xn set of homogeneous points in image A (n at least 4)
%        - B -> 3xn set of homogeneous points in image B (n at least 4)
%
% Output - H -> 3x3 homography matrix 
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [H] = goldStd2DAffine(X1,X2)

    % Check consistency of input
    if(size(X1,2) ~= size(X2,2) || size(X1,1) ~= 3 || size(X2,1) ~= 3 || size(X1,2) < 4)
        error('Both point matrices must be of equal lenght and have 2 dimensions X and Y and at least 4 point correspondances are needed');
    end;

    % First normalize the points
    [X1,t1] = normalize2DpointsCentroid(X1);
    [X2,t2] = normalize2DpointsCentroid(X2);
    
    % Arrange matrix A
    A = zeros(size(X1,2),4);
    for i=1:size(X1,2)
        A(i,:) = [X1(1,i),X1(2,i),X2(1,i),X2(2,i)];
    end;
    
    % Obtain the SVD of A (singular value decomposition)
    [U,S,V] = svd(A);
    
    % Right singular vectors of A corresponding to the two largest singular
    % values o A
    V1 = V(:,1);
    V2 = V(:,2);
    
    % Arrange matrices C and B
    CB = [V1,V2];
    
    C = CB(1:2,1:2);
    B = CB(3:4,1:2);
    
    % Calculate H_2x2
    H22 = C*B^(-1);
    
    % Complete homography
    H = [H22,H22*t1-t2;0,0,1];
    
    
    
    
    
    
    
    
    
    
    
