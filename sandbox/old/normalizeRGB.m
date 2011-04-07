function normalizeRGB(imRGB)
	% todo afmaken
	
	R = imRGB(:,:,1);
	G = imRGB(:,:,2); 
	B = imRGB(:,:,3);
	r = R / (R+G+B)
	g = G / (R+G+B)
	b = B / (R+G+B)
	return [r,g,b]
