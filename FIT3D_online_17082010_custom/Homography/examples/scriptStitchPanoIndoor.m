% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


%% SAMPLE SCRIPT TO STITCH A SERIES OF IMAGES IN AN INDOOR SETTING
% Images taken with a phone-camera.

% Distance threshold
d = 0.4;

% Get path
W = what;


%% Load images for to display
fprintf('\n\n\nREADING IMAGES\n\n\n');
img1 = imread(strcat(install_path,'/Homography/examples/data/ind0.jpg'));
img2 = imread(strcat(install_path,'/Homography/examples/data/ind1.jpg'));
img3 = imread(strcat(install_path,'/Homography/examples/data/ind2.jpg'));

%% Sticth images 1 and 2
fprintf('\n\n\nSTITCHING IMAGES 1 AND 2\n\n\n');
[pano12, H] = stitchImages(strcat(install_path,'/Homography/examples/data/ind0.jpg'),strcat(install_path,'/Homography/examples/data/ind1.jpg'),d);



% Save image
imwrite(pano12,strcat(install_path,'/Homography/examples/data/tmp.jpg'));

%% Stitch the rest of the images

for(i=1:1)
    fprintf('\n\n\nSTITCHING PANORAMIC WITH IMAGE %d\n\n\n',i+1);
    [pano, H] = stitchImages(strcat(strcat(install_path,'/Homography/examples/data/ind'),int2str(i+1),'.jpg'),strcat(install_path,'/Homography/examples/data/tmp.jpg'),d);
    imwrite(pano,strcat(install_path,'/Homography/examples/data/tmp.jpg'));
    
    fprintf('HOMOGRAPHY \n');
    H
    
end;

%% Display final panoramic and images
figure(1),subplot(2,3,1),imshow(img1);
figure(1),subplot(2,3,2),imshow(img2);
figure(1),subplot(2,3,3),imshow(img3);
figure(1),subplot(2,1,2),imshow(pano(1:min(600,size(pano,1)),1:min(1500,size(pano,2)),:));


fprintf('------------------------------------------\n');
fprintf('INPUT:\n\n');
fprintf('- Set of images\n');
fprintf('- Distance threshold\n');
fprintf('------------------------------------------\n');

fprintf('------------------------------------------\n');
fprintf('OUTPUT:\n\n');
fprintf('- Stitched panorama\n');
fprintf('- Homography matrix\n');
fprintf('------------------------------------------\n');

