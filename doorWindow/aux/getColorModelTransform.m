function im = getColorModelTransform(im, Dataset)
if strcmp(Dataset.colorModel,'none') == 1
	%
elseif strcmp(Dataset.colorModel,'HSV_V') == 1
	im = rgb2hsv(im);
	im = im(:,:,3);
elseif strcmp(Dataset.colorModel,'RGB') == 1
	im = im;
elseif strcmp(Dataset.colorModel,'BW') == 1
	im = imadjust(rgb2gray(im));
else
	error('t(jerk)error:colormodel not known');
end
