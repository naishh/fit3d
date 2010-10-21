close all;

P1 = PcamX(:,:,1) % = [I,0]

fullFilename = [Files.dir,Files.files(i).name]
Im = imread(fullFilename);
%figure; imshow(Im);

% the pixel coordinate (faked)
xy = [10;10]
% the homogeneous pixel coordinate 
xyH = [xy;1]

% the pixel in 3d space
xy3D = Kcanon10GOOD * xyH

CameraCenter = [0;0;0]

xyzDirection = xy3D - CameraCenter

% v presents the position on the line (v = 0 = CameraCenter)
% 3dLineEq = CameraCenter + v * xyzDirection

v = 0;
lineCoord1 = CameraCenter + v * xyzDirection

v = 100;
lineCoord2 = CameraCenter + v * xyzDirection


% todo:
% draw the line in 3d 
% get pixels from skyline detector 
