% dlt2D - Direct Linear Transform algorithm for 2D homographies
%
%
% Computes the homography given two sets of corresponding points. Based on
% the DLT algorithm described by Zisserman in p109.
%
%
% Input  - X1 -> 3xn set of homogeneous points in image A
%        - X2 -> 3xn set of homogeneous points in image B
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

function [H] = dlt2D(X1,X2)

    % First normalize the points
    [X1,T1] = normalize2Dpoints(X1);
    [X2,T2] = normalize2Dpoints(X2);
      
    % Arrange the matrix A. Only the first two equations are needed as the
    % last one is redundant
    A = zeros(2*size(X1,2),9);
    for i=1:size(X1,2)
        A(3*i-2,:) = [0,0,0,            -X2(1,i),-X2(2,i),-1, X1(2,i)*X2(1,i), X1(2,i)*X2(2,i), X1(2,i)];
        A(3*i-1,:)   = [X2(1,i),X2(2,i),1, 0,0,0,              -X1(1,i)*X2(1,i),-X1(1,i)*X2(2,i),-X1(1,i)];
    end;
    
    % If the matrix can be built...
    if(sum(sum(isnan(A)))==0)
    
        % Obtain SVD of A
        [U,S,V] = svd(A);

        % The matrix H is composed of the elements of the last vector of V
        h = V(:,end);

        % Reorganice h to obtain H
        H = reshape(h,3,3)';

        % Normalize H
        H = T1\H*T2;
    else
        H = [0/0,0/0,0/0;0/0,0/0,0/0;0/0,0/0,0/0];
    end;
    
