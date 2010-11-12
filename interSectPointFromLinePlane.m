function intSectPoint = interSectPointFromLinePlane(LinePoint0, LinePoint1, PlanePoint0, PlanePoint1, PlanePoint2)
Xa = LinePoint0(1);
Ya = LinePoint0(2);
Za = LinePoint0(3);

Xb = LinePoint1(1);
Yb = LinePoint1(2);
Zb = LinePoint1(3);

X0 = PlanePoint0(1);
Y0 = PlanePoint0(2);
Z0 = PlanePoint0(3);

X1 = PlanePoint1(1);
Y1 = PlanePoint1(2);
Z1 = PlanePoint1(3);

X2 = PlanePoint2(1);
Y2 = PlanePoint2(2);
Z2 = PlanePoint2(3);
% Xa = 90;
% Ya = 0;
% Za = 0;
% 
% Xb = 110;
% Yb = 25;
% Zb = 10;
% 
% X0 = 100
% Y0 = 25;
% Z0 = -25;
% 
% X1 = 100;
% Y1 = 25;
% Z1 = 25;
% 
% X2 = 100;
% Y2 = -25;
% Z2 = 25;

A = [Xa-Xb X1-X0 X2-X0;
	Ya-Yb Y1-Y0 Y2-Y0;
	Za-Zb Z1-Z0 Z2-Z0];
A = inv(A);
B = [Xa - X0;
	Ya - Y0;
	Za - Z0];

TUV = A*B
t = TUV(1)
if ~(t <= 1 && 0 <= t)
	error('debug:NO INTERSECTION')
else
	intSectPoint = [Xa Ya Za] + t*([Xb Yb Zb]-[Xa Ya Za]);
end
