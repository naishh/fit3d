% converts imBW to imRGB and fills the red channel on the location of the white
% pix in imBinary
function im = drawSkyline(imBW, imBinary)
	[w,h] = size(imBW);
	imRGB = zeros(w,h,3);
	imRGB(:,:,1) = imBW;
	imRGB(:,:,2) = imBW;
	imRGB(:,:,3) = imBW;

	%imBW+imBinary;
	imBinary2 = imBinary * 255;
	a = imBW + imBinary2;
	im = min(imBW+imBinary2,255);
	
	

