% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

%% SAMPLE SCRIPT TO STITCH A SERIES OF IMAGES IN AN OUTDOOR SETTING
% Images taken with a DSLR.

% Distance threshold
d = 0.5;

%% Load images for to display
img1 = imread('data/out0.jpg');
img2 = imread('data/out1.jpg');
img3 = imread('data/out2.jpg');
img4 = imread('data/out3.jpg');

%% Sticth images 1 and 2
[pano12, H] = stitchImages('data/out0.jpg','data/out1.jpg',d);



% Save image
imwrite(pano12,strcat(install_path,'/Homography/examples/data/tmp.jpg'));

%% Stitch the rest of the images
for(i=1:2)
    
    fprintf('\n\n\nSTITCHING PANORAMIC WITH IMAGE %d\n\n\n',i+1);
    [pano, H] = stitchImages(strcat(strcat(install_path,'/Homography/examples/data/out'),int2str(i+1),'.jpg'),strcat(install_path,'/Homography/examples/data/tmp.jpg'),d);
    imwrite(pano,strcat(install_path,'/Homography/examples/data/tmp.jpg'));
    
    
    fprintf('HOMOGRAPHY \n');
    H
    
end;

%% Display final panoramic and images
figure(1),subplot(2,4,1),imshow(img1);
figure(1),subplot(2,4,2),imshow(img2);
figure(1),subplot(2,4,3),imshow(img3);
figure(1),subplot(2,4,4),imshow(img4);
figure(1),subplot(2,1,2),imshow(pano);

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
