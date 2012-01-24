% obtainCameraRadialDistortion - Estimates the camera radial distortion
%                                model based on the user selection of 
%                                straight lines
%
%
% Estimates the radial distortion model based on the user selection of
% points that belong to straight lines by minimizing a distance measurement
% between the selected points and the best fit line of the radially 
% corrected points. The model presented by Zisserman is used.
%
%
% Input  - img   -> (mxn)   Image to extract the lines from
%        - K0    -> (kx1)   Initial guess for radial distortion parameters
%        - kc    -> (2x1)   Initial guess for center of radial distortion
%                           (width, height)
%        - n     -> (1x1)   Number of points to extract per line
%        - l     -> (1x1)   Number of lines to select
%        - r     -> (1x1)   Maximum number of function evaluations for the
%                           minimization procedure
%        - X0    -> (nx2xl) Set of n image points that belong to l lines
%
% Output - imgR  -> (mxn)   Corrected image
%        - K     -> (4x1)   Distortion parameters
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [imgR, K, X] = obtainCameraRadialDistortion(img, K0, kc, n,l, r, X0)


% If points are not provided
if(X0==0)

    % Obtain n points in image for every of the l lines
    X = zeros(n,2,l);
    figure(1),imshow(img);
    hold on;
    for j=1:l
        for i=1:n
            [x,y] = ginput(1);
            plot(x,y,'rx');
            X(i,:,j) = [x,y];
            if(i>1)
                line([X(i,1,j),X(i-1,1,j)],[X(i,2,j),X(i-1,2,j)]);  
            end;
        end;
          
    end;
    close(1);
    fprintf('Press any key to start the minimization procedure.');
    pause;

else
    
    X = X0;
    
end;

% Obtain radial distortion
K = getRadialDistortion(X,K0,kc,r);

% Apply distortion to image
[imgR,  minX, minY, divFactor] = getRectifiedImage(K(1:end-2),kc,img);

% Plot image
figure(1);imshow(imgR);





