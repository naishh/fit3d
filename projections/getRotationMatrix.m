% Gets the rotation matrix based on the AxisAngle theory
% INPUT
%
% xyz   =  vector representing the rotational axis
% angle = angle to rotate (counterclockwise) 
%
function R = getRotationMatrix(xyz, angle)
c = cos(angle);
s = sin(angle);
t = 1 - c;

% normalize rotation vector
normXYZ = norm([xyz(1),xyz(2),xyz(3)]);
x=xyz(1)/normXYZ;
y=xyz(2)/normXYZ;
z=xyz(3)/normXYZ;

% rotation matrix
R =[t*x*x+c 	t*x*y-z*s 	t*x*z+y*s;...
	t*x*y+z*s 	t*y*y+c 	t*y*z-x*s;...
	t*x*z-y*s 	t*y*z+x*s 	t*z*z+c];
