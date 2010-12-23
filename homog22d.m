function v = homog22d(XYZ)
	XYZ = XYZ / XYZ(3);
	v = [XYZ(1);XYZ(2)];
