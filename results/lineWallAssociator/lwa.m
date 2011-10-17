close all;
load Walls


wall10 = [-1.4525   , 1.0394   , 7.0732 ,  -1.4797  , -2.9551   , 7.2823  , -7.3021 ,  -2.9420  , 11.0830,  -7.2749 ,   1.0524 ,  10.8739];

a=wall10(7:9)
b=wall10(4:6)

% adjust Y (naar beneden)
a(2) = a(2)*0.8; 
b(2) = b(2)*0.8; 

%adjust Z
a(3) = a(3)-2; 
b(3) = b(3)-2; 

 
p1 = a;
p2 = a;
p3 = b; 
p4 = b;

% adjust X
p1(1) = a(1)-3; 
p4(1) = b(1)+3; 

p2(1) = a(1)+2; 
p3(1) = b(1)-2; 

p35=b
p35(1)=b(1)+0.5

% 
% %adjust Z
% a(3) = a(3)-3; 
% b(3) = b(3)-1; 

plotBuilding(Walls,[]);
plot3aux(b,p4,'r+--');
plot3aux(p3,b,'b+-');


plotBuilding(Walls,[]);
plot3aux(p2,p3,'b+-');

plotBuilding(Walls,[]);
plot3aux(p1,a,'r+--');
plot3aux(b,p4,'r+--');
plot3aux(a,b,'b+-');

plotBuilding(Walls,[]);
plot3aux(p35,p4,'r+--');

% todo:
% vooraanzicht 3d model ander kleurtje
