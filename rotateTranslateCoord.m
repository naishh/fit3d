function coordRT = rotateTranslateCoord(coord, P)
	% this goes wrong at the third image because its relative
	R = P(:,1:3);
	T = P(:,4);
	coordRT = coord - R*T;
