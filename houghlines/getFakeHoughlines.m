function fakeHoughlines = getFakeHoughlines()

endRange = 1;
totLines = 7
for imNr = 1:endRange

	% READ IMAGE 
	% starts with outd0 not with outd1
	imNrFile = imNr - 1
	file = sprintf('../dataset/FloriandeSet1/img/outd%d.jpg', imNrFile)

	imRGB = imread(file);
	[h,w] = size(imRGB)

	figure;
	imshow(imRGB)

	for lineNr = 1:totLines
		[x, y] = ginput(2)
		fakeHoughlines{imNr}(lineNr).point1 = [x(1),y(1)]
		% translate origin from lefttop to leftbottom
		fakeHoughlines{imNr}(lineNr).point2 = [x(2),y(2)]
	end

end


save fakeHoughlines

