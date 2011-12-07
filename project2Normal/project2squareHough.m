close all;
%load Houghlines3d
load Houghlines3dWall
load Walls



% % the y axis is inverted because matlab plots upside down
% % this is to flip the y axis 
yHeight = 200;
wallNr = 7;
wallNormal = getNormalFromWall(Walls, wallNr)
wallNormal = wallNormal/norm(wallNormal) % normalise wall normal
zAxis = [0 0 1];
rotationVector = cross(zAxis, wallNormal)
angle = acos(dot(zAxis, wallNormal)) % could also be -R!!
R = getRotationMatrix(rotationVector, angle)
T = [0 0 0]


% TODO GET EDGE IMAGE set houghlines in loop below
% TODO optimize to get fast matrix calculation

X = [];
Y = [];
xyPoint1 = homog22D(inv(R) * Walls(Nr,1:3)');
xyPoint2 = homog22D(inv(R) * Walls(Nr,4:6)');

X = [X,xyPoint1(1),xyPoint2(1)];
Y = [Y,xyPoint1(2),xyPoint2(2)];

% xyPoint1 = homog22D(inv(R) * Walls(Nr,7:9)');
% xyPoint2 = homog22D(inv(R) * Walls(Nr,10:12)');
% X = [X,xyPoint1(1),xyPoint2(1)];
% Y = [Y,xyPoint1(2),xyPoint2(2)];


figure;
hold on;
% plot individual line segments
for xi=1:2:length(Xwall)
	plot(Xwall(xi:xi+1), Ywall(xi:xi+1), 'r-')
end



