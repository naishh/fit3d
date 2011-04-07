% rescales an image to value between 0 and 1 using the full spectrum
function imOut = rescale(im)
	mn = min(min(im));
	imOut = im - mn;
	imOut = im / max(max(im));
end

