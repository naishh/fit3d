function R = getRotationMatrixFromWallNormal(Walls,wallNr)
	wallNormal = getNormalFromWall(Walls, wallNr)

	% TODO maybe this has to be the viewing direction of the current P
	zAxis = [0 0 1];

	% normalise wall normal
	wallNormal = wallNormal/norm(wallNormal)
	rotationVector = cross(zAxis, wallNormal)

	%for anglePercentage=0.2:0.2:1
	%angle = acos(dot(zAxis, wallNormal))*anglePercentage
	angle = acos(dot(zAxis, wallNormal))

	% could also be -R!!
	R = getRotationMatrix(rotationVector, angle)
end
