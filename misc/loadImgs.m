function imgs = loadImgs(startPath, imNrStart,imNrEnd)
for imNr=imNrStart:imNrEnd
	%file = sprintf([startPath, '/dataset/FloriandeSet1/img/outd%d.jpg'], imNr-1)
	%quickfix for windows
	file = sprintf(['../dataset/FloriandeSet1/small/outd%d.jpg'], imNr-1)
	imgs{imNr} = imread(file);
end
