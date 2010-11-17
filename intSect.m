LinePoint0 = [0 0 0];
LinePoint1 = [4 -2 30];
PlanePoint0 = [11 -1 30];
PlanePoint1 = [-1 -2 11];
PlanePoint2 = [-1 1 10];

intSectPoint = interSectPointFromLinePlane(LinePoint0, LinePoint1, PlanePoint0, PlanePoint1, PlanePoint2)



file = 'cubeTest.obj';
lastF = 0;
center = round(intSectPoint)
r = 3;
cubeToObj(file, lastF, center, r);
