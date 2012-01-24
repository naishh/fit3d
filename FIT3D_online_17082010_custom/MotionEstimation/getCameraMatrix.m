% getCameraMatrix - Given an essential matrix, compute the corresponding
% camera matrix P as a rotation and translation.
%
%
% Given the essential matrix, it is decomposed and 4 possible camera
% matrices are calculated in the form [R|T]. Based on the method presented
% in Hartley & Zisserman in p259
%
%
% Input  - E     -> (3x3) Essential matrix
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

function [PXcam] = getCameraMatrix(E)


    % SVD of E
    [U,S,V] = svd(E);
       
    % Matrix W
    W = [0,-1,0;1,0,0;0,0,1];
        
    % Compute 4 possible solutions (p259) and scale the translation vectors
    PXcam = zeros(3,4,4);
    
    PXcam(:,:,1) = [U*W*V',U(:,3)./max(abs(U(:,3)))];
    PXcam(:,:,2) = [U*W*V',-U(:,3)./max(abs(U(:,3)))];
    PXcam(:,:,3) = [U*W'*V',U(:,3)./max(abs(U(:,3)))];
    PXcam(:,:,4) = [U*W'*V',-U(:,3)./max(abs(U(:,3)))];
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
