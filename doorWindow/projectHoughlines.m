
% asumes houghlines are loaded
Dataset.HoughResult.Houghlines

load('WallsPc_SpilRect.mat')

wallNormal = getNormalFromWall(WallsPc, 1, 0)

zAxis = [0 0 1];
rotationVector = cross(zAxis, wallNormal)
angle = acos(dot(zAxis, wallNormal)) % could also be -R!!
R = getRotationMatrix(rotationVector, angle)

%Dataset.HoughlinesProj = 


see project2Normal/project2squareHough
