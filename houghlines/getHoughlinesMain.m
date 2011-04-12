% this file saves the houghlines found in the images
load imBWSkylines
for imNr=1:3
	imNr
	Houghlines{imNr} = getHoughlines(imBWSkylines{imNr}, 1);
end
save Houghlines
