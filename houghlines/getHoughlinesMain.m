% this file saves the houghlines found in the images
load('../mats/imsSkyLineBinary.mat', 'imsSkyLineBinary');
for imNr=1:length(imsSkyLineBinary)
	%close all;
	imNr
	Houghlines2d{imNr} = getHoughlines(imsSkyLineBinary{imNr}, 1);
end
disp('saving Houghlines...');
save('../mats/Houghlines2d.mat','Houghlines2d')
