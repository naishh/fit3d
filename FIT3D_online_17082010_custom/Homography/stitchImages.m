% stitchImages - Stitches two images together to form a single panoramic image 
%
% Stitches two images together using SIFT to extract interesting points in
% each image, a distance measure to determine point matches and the
% normalized Linear Transform algorithm to determine the homography
%
%
% Input  - im1          -> (1x1) image file 1
%        - im2          -> (1x1) image file 2
%        - distRatio    -> (1x1) distance measure to check if two SIFT features
%                          are the same
%
% Output - finalImage   -> (nxmxc) a panoramic image 
%        - H            -> (3x3) Homography
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [finalImage, H] = stitchImages(im1,im2, distRatio)

    % Check if the images are RGB or grayscale
    tmpim1 = im2double(imread(im1));
    tmpim2 = im2double(imread(im2));
    
    % Set the color mode
    if(size(tmpim1,3)==1 || size(tmpim2,3)==1)
        RGB = false;
    else
        RGB = true;
    end;
    
    % Find features in both images
    [f1,d1] = vl_sift(single(rgb2gray(tmpim1)));
    [f2,d2] = vl_sift(single(rgb2gray(tmpim2)));
    [matches, scores] = vl_ubcmatch(d1, d2, 5.5);
    X1 = ones(3,size(matches,2));
    X2 = ones(3,size(matches,2));
    X1(1:2,:) = [f1(1,matches(1,:))-1;f1(2,matches(1,:))-1];
    X2(1:2,:) = [f2(1,matches(2,:))-1;f2(2,matches(2,:))-1];
    
    numOfMatches = size(matches,2);
    
    fprintf('Matches found:%d\n',numOfMatches);


    % Obtain HOMOGRAPHY (4 different techniques)
    %H = dlt2D(X1,X2);
    %H = goldStd2DAffine(X1,X2);
    %H = goldStd2D(X1,X2);
    H = ransac2D(X1,X2);
    
    
    % Stitch the images
    finalImage = buildPanorama(tmpim1,tmpim2,H);

    
    
    
    
    
    
    
