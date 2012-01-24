% symmetricTransferError - Computes the geometric error given the set of original
% points, transformed points according to an homography and measure points
% (the target).  
%
% Given a set of points it calculates the error based on
% the geometric error function  described by Zisserman in p95. 
%
%
% Input  - X1 -> (2xn) set of homogeneous points in image A
%        - X2 -> (2xn) set of homogeneous points in image B
%        - H  -> (3x3) homography
%
% Output - e  -> (1xn) error
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [e] = symmetricTransferError(X1,X2,H)
    
    % Transform the points
    X2p = H^(-1)*X1;
    X2p = X2p/X2p(3,:);
    X1p = H*X2;
    X1p = X1p/X1p(3,:);

    % Compute the error
    e = sqrt((X1(1,:)'-X1p(1,:)').^2 + (X1(2,:)'-X1p(2,:)').^2 + (X2(1,:)'-X2p(1,:)').^2 + (X2(2,:)'-X2p(2,:)').^2);
    
    
    
    
