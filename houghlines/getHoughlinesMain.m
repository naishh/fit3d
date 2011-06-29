% this file saves the houghlines found in the images
load imBWSkylines
for imNr=1:length(imBWSkylines)
	close all;
	imNr
	Houghlines2d{imNr} = getHoughlines(imBWSkylines{imNr}, 1);
end
disp('saving Houghlines...');
save('../mats/Houghlines2d.mat','Houghlines2d')
