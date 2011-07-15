% plotCamera - Plots a camera in a figure as a piramid with the center of
% the camera in the vertex
%
%
% Input  - R         -> (3x3) Rotation matrix
%        - T         -> (3x1) Translation vector
%        - f         -> (1x1) Focal length
%        - imageSize -> (2x1) Size of image
%        - figureH   -> (1x1) Figure handler 
%        - plot      -> (1x1) Plot or not
%
% Output - CCn       -> (3x1) Camera center
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function CCn = plotCamera(R,T,f,imageSize, figureH, plot)

% Calculate 4 points (camera center at origin)
% Camera center
CC = [0;0;0];
% Left top corner
LT = [-imageSize(1)/2;imageSize(2)/2;f];
% Right top corner
RT = [imageSize(1)/2;imageSize(2)/2;f];
% Left bottom corner
LB = [-imageSize(1)/2;-imageSize(2)/2;f];
% Right bottom corner
RB = [imageSize(1)/2;-imageSize(2)/2;f];


% Rotate and translate all 5 points
CCn = R*CC+T;
LTn = R*LT+T;
RTn = R*RT+T;
LBn = R*LB+T;
RBn = R*RB+T;

% Plot camera
if(plot)
    figure(figureH), line([CCn(1),LTn(1)],[CCn(2),LTn(2)],[CCn(3),LTn(3)]);
    figure(figureH), line([CCn(1),RTn(1)],[CCn(2),RTn(2)],[CCn(3),RTn(3)]);
    figure(figureH), line([CCn(1),LBn(1)],[CCn(2),LBn(2)],[CCn(3),LBn(3)]);
    figure(figureH), line([CCn(1),RBn(1)],[CCn(2),RBn(2)],[CCn(3),RBn(3)]);

    figure(figureH), line([RTn(1),LTn(1)],[RTn(2),LTn(2)],[RTn(3),LTn(3)]);
    figure(figureH), line([RBn(1),LTn(1)],[RBn(2),LTn(2)],[RBn(3),LTn(3)]);
    figure(figureH), line([RTn(1),LBn(1)],[RTn(2),LBn(2)],[RTn(3),LBn(3)]);
    figure(figureH), line([RBn(1),LBn(1)],[RBn(2),LBn(2)],[RBn(3),LBn(3)]);
    figure(figureH), line([LTn(1),LBn(1)],[LTn(2),LBn(2)],[LTn(3),LBn(3)]);
    figure(figureH), line([RTn(1),RBn(1)],[RTn(2),RBn(2)],[RTn(3),RBn(3)]);
end;
