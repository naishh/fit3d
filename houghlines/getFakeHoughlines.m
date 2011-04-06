function getFakeHoughlines()

endRange = 1;
for imNr = 1:endRange

	% READ IMAGE 
	% starts with outd0 not with outd1
	imNrFile = imNr - 1
	file = sprintf('../dataset/FloriandeSet1/img/outd%d.jpg', imNrFile)
	imRGB = imread(file);
	figure;
	imshow(imRGB)

	[fakeHoughlines{imNr}.point1, fakeHoughlines{imNr}.point2] = ginput(2)

end

