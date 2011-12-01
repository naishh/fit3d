% calculates the angle of a line given by the input coords
% see matlab doc hough
function theta = calcHoughTheta(x1,y1,x2,y2,h)
% invert y axis
y1 = h-y1;
y2 = h-y2;
% calc sides overstaande en aanliggende
o = y2-y1;
a = x2-x1;
% calc angle
theta = atan(o/a);
%degree to radian
theta = theta * (180/pi);
% subtract 90 because houghtransform
% theta = theta - 90 ;
% % clockwise 
% theta = -theta;
