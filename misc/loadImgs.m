function imgs = loadImgs(startPath, imNrStart,imNrEnd)
i=1;
for imNr=imNrStart:imNrEnd
	imNr
	%file = sprintf([startPath, '/dataset/FloriandeSet1/img/outd%d.jpg'], imNr-1)
	%quickfix for windows
	%file = sprintf(['../dataset/FloriandeSet1/small/outd%d.jpg'], imNr-1)
	file = sprintf(['../dataset/FloriandeSet1/medium/undist__MG_%d.jpg'], imNr);
	imgs{i} = imread(file);
	i=i+1;
end
