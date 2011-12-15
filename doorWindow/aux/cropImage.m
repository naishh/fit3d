function imBW2 = cropImage(imBW, xCrop, yCrop);
xCrop = round(xCrop);
yCrop = round(yCrop);
imBW2 = imBW(yCrop(1):yCrop(2), xCrop(1):xCrop(2), size(imBW,3));
