% normPanoramic - Normalizes a panoramic to be displayed in a rectangle 
%
% When stitching two images, the image that is adjusted to the other is
% warped a certain amount that depends on the scene (far away scenes
% require less warping). When this occurs, interpolation is required and
% the image that is warped losses quality rapidly, specially if you want 
% to stitch more than two images. To preven this, this function calculates 
% a new homography that modifies the panoramic so that it is visualized
% in a nice rectangle. For that, 4 set of corresponding points need to 
% be given, typically, the corners on the warped image and the corners of
% the new target rectangular image.
%
%
% Input  - panoramic           -> (nxmxc) panoramic warped image
%        - Xpano               -> (4x2) set of 4 points in the panoramic image
%                                 that will be mapped to the corners of the 
%                                 normalized image (LEFT UPPER, LEFT LOWER, 
%                                 RIGHT UPPER, RIGHT LOWER)
%        - width               -> (1x1) desired width
%        - height              -> (1x1) desired height
%        - interpolationFactor -> (1x1) the factor to use for the
%                                 interpolation (too low and it will be to
%                                 slow)
%
% Output - normalizedPanoramic -> (npxmpxc) a panoramic image visualized in a rectangle 
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function finalImage = normPanoramic(panoramic, Xpano, width, height, interpolationFactor)

    % If the image is the path, read it
    if(size(panoramic,1)==1)
        image = imread(panoramic);
    else
        image = panoramic;
    end;

    % Set color or grayscale
    if(size(image,3)==1)
        RGB= false;
    else
        RGB = true;
    end;
    
    % Convert to double
    image = im2double(image);
    
    % Set target points (corners of the rectangle)
    Xtarget = [1,1,width,width;1,height,1,height];
    
    % Obtain HOMOGRAPHY
    H = dlt2D(Xtarget,Xpano);
    
    % Transform points in the first image to points of the second image
    factor = interpolationFactor;
    if(RGB)
        channels = 3;
    else
        channels = 1;
    end;
    imageCoords = zeros(size(image,1)*size(image,2)*(1/factor)*(1/factor),2+channels);
    counter = 1;
    for i=1:factor:size(image,1)
        for j = 1:factor:size(image,2)
            nX = H*[j;i;1];
            nX = nX./nX(3);
            imageCoords(counter,1:2) = [nX(2),nX(1)];
            for c =1:size(image,3)
                if(i>=2 && i<= size(image,1)-1 && j >=2 && j<= size(image,2))
                    color = (image(floor(i),floor(j),c)+image(ceil(i),floor(j),c)+image(floor(i),ceil(j),c)+image(ceil(i),ceil(j),c))/4;
                else
                    color = image(floor(i),floor(j),c);
                end;
                imageCoords(counter,2+c) = [color];
            end;
            counter = counter+1;
        end;
    end;
    
    % Populate image
    finalImage = zeros(ceil(height),ceil(width),channels);
    for i=1:size(imageCoords,1)
        for c = 1:size(finalImage,3)
            if(ceil(imageCoords(i,1))+1>1 && ceil(imageCoords(i,1))+1<height && ceil(imageCoords(i,2))+1>1 && ceil(imageCoords(i,2))+1<width)
                finalImage(ceil(imageCoords(i,1))+1,ceil(imageCoords(i,2))+1,c) = imageCoords(i,2+c);
            end;
        end;
    end;
