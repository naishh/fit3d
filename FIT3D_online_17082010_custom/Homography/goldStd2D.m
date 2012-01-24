% goldStd2D - Gold Standard Algorithm for 2D homographies
%
%
% Computes the homography given two sets of corresponding points. Based on
% the Gold Standard Algorithm described by Zisserman in p130.
%
%
% Input  - A -> 3xn set of homogeneous points in image A
%        - B -> 3xn set of homogeneous points in image B
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

function [H] = goldStd2D(X1,X2)

    % Initialization
    % First estimate H using DLT
    Hini = dlt2D(X1,X2);
    
    % Minimize the function using Levenberg-Marquardt
    H = lsqnonlin(@(h) symmetricTransferError(X1,X2,h),Hini);
