function imBW = cropImage(imBW, xCrop, yCrop);
% crop image by rectangle
h = size(imBW,1);
w = size(imBW,2);
for y=1:h 
	for x=1:w
		% set values outside crop window to zero
		if (y<yCrop(1) || y>yCrop(2)) || (x<xCrop(1) || x>xCrop(2))
			imBW(y,x) = 0;
		end
	end
end
