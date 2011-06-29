% this file saves the houghlines found in the images
load imBWSkylines
for imNr=1:length(imBWSkylines)
	imNr
	Houghlines{imNr} = getHoughlines(imBWSkylines{imNr}, 1);
end
disp('saving Houghlines...');
save('../mats/Houghlines.mat','Houghlines')
