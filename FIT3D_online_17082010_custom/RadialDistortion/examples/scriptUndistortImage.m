% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

%% Script to compute the radial distortion parameters of an image

% We follow the radial distortion model from Zisserman (p.190)

%% First, read the image and display it.
img = imread('original.jpg');

%% Set the parameters
% Number of lines
nLines = 3;
% Number of points per line
nPoints = 3;
% Initial values for the distortion parameters (if known)
K0 = [0;0;0;0];
% Center of distortion (the center of the image by default, [X,Y])
kc = [size(img,2)/2;size(img,1)/2];
% Number of iterations for the minimization
nIterations = 500;
% Set of image points (if known)
X0 = 0;

%% Compute the distortion parameters based on 3 straight lines of 3 points each
fprintf('\n\n Please select %d points for every of the %d lines.\n\n',nPoints,nLines);
[imgR, K, X] = obtainCameraRadialDistortion(img, K0, kc, nPoints,nLines, nIterations, X0);

fprintf('------------------------------------------\n');
fprintf('INPUT:\n\n');
fprintf('- Image\n');
fprintf('- Number of points per line\n');
fprintf('- Number of lines\n');
fprintf('------------------------------------------\n');

fprintf('------------------------------------------\n');
fprintf('OUTPUT:\n\n');
fprintf('- Undistorted image\n');
fprintf('- Radial distortion parameters\n');
fprintf('------------------------------------------\n');


fprintf('Distortion parameters: [%d,%d,%d,%d]\n',K(1),K(2),K(3),K(4));
fprintf('Center of distortion: [%d,%d]\n',K(5),K(6));

fprintf('\n\n\nThe image has been undistorted.\n Please note that results might vary depending on which straight lines you selected. \n For more information please read the paper at www.fit3d.info.\n\n\n');
