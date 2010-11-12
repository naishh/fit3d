% a = [100, 25, -25]
% b = [100, 25, 25]
% c = [100, -25, 25]
% 
% u = (b - a)
% v = (c - a)
% 
% cross(u,v)
% 

Xa = 90;
Ya = 0;
Za = 0;

Xb = 110;
Yb = 25;
Zb = 10;

X0 = 100
Y0 = 25;
Z0 = -25;

X1 = 100;
Y1 = 25;
Z1 = 25;

X2 = 100;
Y2 = -25;
Z2 = 25;

LinePoint0 = [Xa, Ya, Za];
LinePoint1 = [Xb, Yb, Zb];

PlanePoint0 = [X0, Y0, Z0];
PlanePoint1 = [X1, Y1, Z1];
PlanePoint2 = [X2, Y2, Z2];

intSectPoint = interSectPointFromLinePlane(LinePoint0, LinePoint1, PlanePoint0, PlanePoint1, PlanePoint2)

