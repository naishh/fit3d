% findTriangulationLM - Find the 3D points given the fundamental matrix and
% a set of corresponding points
%
%
% Given the fundamental matrix and a set of corresponding points, the 3D
% points where the rays intercept are found by minimizing a cost function
% as described by Zisserman in p.314 using the LM algorithm.
%
%
% Input  - X1   -> (nx3) set of homogeneous points in image A
%        - X2   -> (nx3) set of homogeneous points in image B
%        - P1   -> (3x4) First camera matrix
%        - P2   -> (3x4) Second camera matrix
%        - K1   -> (3x3) First camera calibration
%        - K2   -> (3x3) Second camera calibration
%        
%
% Output - X3D  -> (3xn) Triangulated 3D points
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [X3D] = findTriangulationLM(X1,X2,P1,P2,K1,K2)

    
    % Get only the image points
    x1 = X1(:,1:2);
    x2 = X2(:,1:2);
    
       
    % Triangulate those points
    for i=1:size(x1,1)
        
        % Obtain 3D image points   
        xphat = inv(K1)*X1(i,1:3)';
        xqhat = inv(K2)*X2(i,1:3)';
        %xphat = X1(i,1:3)';
        %xqhat = X2(i,1:3)';
        
        % Build matrix A 
        A = [xphat(1)*P1(3,:)-P1(1,:);
             xphat(2)*P1(3,:)-P1(2,:);
             xqhat(1)*P2(3,:)-P2(1,:);
             xqhat(2)*P2(3,:)-P2(2,:)];

        % Normalize A
        A1n = sqrt(sum(A(1,:).*A(1,:)));
        A2n = sqrt(sum(A(2,:).*A(2,:)));
        A3n = sqrt(sum(A(3,:).*A(3,:)));
        A4n = sqrt(sum(A(4,:).*A(4,:))); 
        Anorm = [A(1,:)/norm(A(1,:));
                 A(2,:)/norm(A(2,:));
                 A(3,:)/norm(A(3,:));
                 A(4,:)/norm(A(4,:))];

        % Obtain the 3D point
        %[Uan,San,Van] = svd(Anorm);
        [Uan,San,Van] = svd(Anorm);
        
        X3D(:,i) = Van(:,end);    
                
        % Normalize 3D point to get points NOT in infinity
        X3D(:,i) = X3D(:,i)./X3D(4,i);
        %X3D(:,i) = X3D(:,i)./norm(X3D(1:3,i));
        
        
 
    end;

  

  

