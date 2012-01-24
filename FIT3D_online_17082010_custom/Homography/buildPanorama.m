% buildPanorama - Given two images and the homography that describes their
% relation, a panorama is built.
%
% 
% Given two images and the homography that describes their relation, a
% panorama is built using both images. We use the interp2 function in
% matlab to interpolate. BUG: when the motion is from left to right, the
% resulting image expands a bit too much (black areas).
%
%
% Input  - im1   -> (nxm) Image 1 (in matrix format) 
%        - im2   -> (kxd) Image 2 (in matrix format)
%        - H     -> (3x3) Homography between images 1 and 2
%
% Output - Zpano -> (txy) Panoramic image (both stitched together)
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function Zpano = buildPanorama(im1,im2,H)

    if(size(im1,3)==1 && size(im2,3)==1)
        im1 = im1./max(max(im1));
        im2 = im2./max(max(im2));
    end;

    % Find limits of transformed image
    p11 = [1;1;1];
    p12 = [size(im2,2);1;1];
    p21 = [1;size(im2,1);1];
    p22 = [size(im2,2);size(im2,1);1];

    Hp11 = H*p11;
    Hp11 = Hp11./Hp11(3);
    Hp12 = H*p12;
    Hp12 = Hp12./Hp12(3);
    Hp21 = H*p21;
    Hp21 = Hp21./Hp21(3);
    Hp22 = H*p22;
    Hp22 = Hp22./Hp22(3);

    corners = [Hp11,Hp12,Hp21,Hp22];

    maxX = max(corners(1,:));
    maxY = max(corners(2,:));

    minX = min(corners(1,:));
    minY = min(corners(2,:));

    % Original widht and height
    widthO = size(im1,2);
    heightO = size(im1,1);

    LowerX = min(1,-minX);
    LowerY = min(1,-minY);
    HigherX = max(widthO-minX,maxX-minX);
    HigherY = max(heightO-minY,maxY-minY);
    
    % Create grid
    [xi,yi] = meshgrid(LowerX:HigherX,LowerY:HigherY);

    % Transform points
    xic = reshape(xi,size(xi,1)*size(xi,2),1);
    yic = reshape(yi,size(yi,1)*size(yi,2),1);

    Hxic = xic;
    Hyic = yic;

    for i=1:size(xic,1)
        nx = H*[xic(i);yic(i);1];
        nx = nx./nx(3);
        Hxic(i) = nx(1);
        Hyic(i) = nx(2);
    end;

    Hxic = reshape(Hxic,size(xi,1),size(xi,2));
    Hyic = reshape(Hyic,size(yi,1),size(yi,2));

    % Interpolate images
    for(k=1:3)
        Z1(:,:,k) = interp2(im2double(im1(:,:,k)),Hxic,Hyic);
        Z2(:,:,k) = interp2(im2double(im2(:,:,k)),xi,yi); 
    end;


    Z1(isnan(Z1)) = 0;
    Z2(isnan(Z2)) = 0;
    
    % Final image
    Zpano = zeros(size(Z1));
    % Mixture with pixels that are defined in both images
    Zpano(~isnan(Z2) & ~isnan(Z1)) = (0.9*Z1(~isnan(Z2) & ~isnan(Z1))+0.1*Z2(~isnan(Z2) & ~isnan(Z1)));
    % Points thare are defined only in one image
    Zpano(Z1==0 & Z2~=0) = Z2(Z1==0 & Z2~=0);
    Zpano(Z2==0 & Z1~=0) = Z1(Z2==0 & Z1~=0);


    
