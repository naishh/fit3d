function v = homog22D(XYZ)
	XYZ = XYZ / XYZ(3);
	v = [XYZ(1);XYZ(2)];
