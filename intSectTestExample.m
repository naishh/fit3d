LinePoint0 = [0 0 0];
LinePoint1 = [4 -2 30];
PlanePoint0 = [11 -1 30];
PlanePoint1 = [-1 -2 11];
PlanePoint2 = [-1 1 10];

intSectPoint = interSectPointFromLinePlane(LinePoint0, LinePoint1, PlanePoint0, PlanePoint1, PlanePoint2)



file = 'Buildings_line.obj';
lastF = 0;
center = intSectPoint
r = 0.1;
cubeToObj(file, lastF, center, r);
!osgviewer Buildings_line.obj
