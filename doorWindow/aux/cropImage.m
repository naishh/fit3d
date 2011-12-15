function imBW2 = cropImage(imBW, xCrop, yCrop);
xCrop = round(xCrop);
yCrop = round(yCrop);
imBW2 = zeros(yCrop(2)-yCrop(1),xCrop(2)-xCrop(1),size(imBW,3));

% crop image by rectangle
h = size(imBW,1);
w = size(imBW,2);
for y=1:h 
	for x=1:w
		% copy values inside crop window 
		if (y>yCrop(1) && y<yCrop(2)) && (x>xCrop(1) && x<xCrop(2))
			imBW2(y-yCrop(1)+1,x-xCrop(1)) = imBW(y,x,:);
		end
	end
end
