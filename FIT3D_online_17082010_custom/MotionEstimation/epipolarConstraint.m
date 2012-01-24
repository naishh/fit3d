% epipolarConstraint - Epipolar constraint 
%
%
% This function represents the epipolar constraint where p'*F*q = 0
%
%
% Input  - X1X2 -> 4xn set of homogeneous points in image A and B
%        - F    -> 3x3 fundamental matrix
%
% Output - c    -> 1xn p'*F*q
%          ceq  -> 1xn zeros
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [c,ceq] = epipolarConstraint(X1X2,F)


    X1 = [X1X2(1:2,:);ones(1,size(X1X2,2))];
    X2 = [X1X2(3:4,:);ones(1,size(X1X2,2))];
    
    c = zeros(size(X1X2,2),1);
    
    for i=1:size(X1X2,2)
        c(i) = X2(:,i)'*F*X1(:,i);
    end;
    
    ceq = c;
    c = [];
