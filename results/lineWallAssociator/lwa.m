close all;
load Walls


wall10 = [-1.4525   , 1.0394   , 7.0732 ,  -1.4797  , -2.9551   , 7.2823  , -7.3021 ,  -2.9420  , 11.0830,  -7.2749 ,   1.0524 ,  10.8739];

x1 = wall10(4);
y1 = wall10(5);
z1 = wall10(6);
x2 = wall10(7);
y2 = wall10(8);
z2 = wall10(9);

% adjust Y (move line down)
y1 = y1 + 1; 
y2 = y2 + 1; 

%adjust Z (move more to front)
z1 = z1 - 1;
z2 = z2 - 1;

% full overlap
plotBuilding(Walls,[]);
plot3([x1,x2],[y1,y2],[z1,z2],'b+-');


% adjust X (move to right)
x2=x1;
y2=y1;
z2=z1;
x1 = x1 + 3; 
%x2 = x1 + 1; 

plot3([x1,x2],[y1,y2],[z1,z2],'r+-');




