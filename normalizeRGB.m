function normalizeRGB(imRGB)
	R = imRGB(:,:,1);
	G = imRGB(:,:,2); 
	B = imRGB(:,:,3);
	r = R / (R+G+B)
	g = G / (R+G+B)
	b = B / (R+G+B)
	% todo afmaken
	return [r,g,b]
