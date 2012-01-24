% getRectifiedImage - Compensates for radial distortion in the given image
%
%
% Given the radial distortion parameters based on Zisserman´s model (p.135)
% and the center of distortion (typically the center of the image) it 
% corrects the given image. NOTE: very unefficient.
%
%
% Input  - K    -> (4x1)   Radial distortion parameters.
%        - Xc   -> (2x1)   Center of radial distortion
%        - img  -> (mxn)   Image
%
% Output - imgR -> (mxn)   Corrected image 
%        - minX -> (1x1)   Left limit of the image
%        - mixY -> (1x1)   Top limit of the image
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [imgR, minX, minY, divFactor] = getRectifiedImage(K,Xc,img)

% Convert image to double
img = im2double(img);


% Create set of points to rectify with an increase factor
increaseFactor = 2;
iX = zeros(size(img,1)*size(img,2)*increaseFactor*increaseFactor,2);
counter = 1;
for i=1:(1/increaseFactor):size(img,2)
    for j = 1:(1/increaseFactor):size(img,1)
        %iX(i*size(img,1)-size(img,1)+j,:) = [i,j];
        iX(counter,:) = [i,j];
        counter = counter+1;
    end;
end;


% Rectify points
Ximg = getRectifiedPoints(K,Xc,iX);

% Obtain minimums 
minX = min(Ximg(:,1));
minY = min(Ximg(:,2));

% Translate image to positive space if its negative
Ximg(:,1) = Ximg(:,1)-(minX<0)*minX+1;
Ximg(:,2) = Ximg(:,2)-(minY<0)*minY+1;

% Shift center if its in positive space
Ximg(:,1) = Ximg(:,1)-(minX>0)*minX+1;
Ximg(:,2) = Ximg(:,2)-(minY>0)*minY+1;

%divFactor = 1;
divFactor = (abs(max(max(Ximg(:,2)),max(Ximg(:,1))))/min(size(img,2),size(img,1)))/2;
Ximg = ceil(Ximg./divFactor);

% Create new image
imgR = zeros( max(Ximg(:,2))+1,max(Ximg(:,1))+1,size(img,3));


% Populate new image
for i=1:size(iX,1)
    for j=1:size(img,3)
        if (floor(iX(i,2)) > 0 && floor(iX(i,1)) > 0 && ceil(iX(i,2)) < size(img,1) &&  ceil(iX(i,1)) < size(img,2));
            imgR(Ximg(i,2),Ximg(i,1),j) = (img(floor(iX(i,2)),floor(iX(i,1)),j)+img(ceil(iX(i,2)),floor(iX(i,1)),j)+img(floor(iX(i,2)),ceil(iX(i,1)),j)+img(ceil(iX(i,2)),ceil(iX(i,1)),j))/4; 
        end;
    end;
end;

