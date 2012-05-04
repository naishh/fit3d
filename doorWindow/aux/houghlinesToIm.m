% turns houghlines into pixel images using bresenham (wikipedia)
function [ImV,ImH] = houghlinesToIm(Dataset, plotme)
	inpIm = ones(Dataset.ImReader.imHeight, Dataset.ImReader.imWidth);
	ImV = zeros(Dataset.ImReader.imHeight, Dataset.ImReader.imWidth);
	ImH = zeros(Dataset.ImReader.imHeight, Dataset.ImReader.imWidth);
	for i=1:length(Dataset.HoughResult.V.Lines)
		round(i/length(Dataset.HoughResult.V.Lines)*100)
		lineCoord = [Dataset.HoughResult.V.Lines(i).point1;
					 Dataset.HoughResult.V.Lines(i).point2];
		[myline,mycoords,outpIm,X,Y] = bresenham(inpIm, lineCoord, 0);
		ImV = ImV  + (1-outpIm);
	end
	for i=1:length(Dataset.HoughResult.H.Lines)
		round(i/length(Dataset.HoughResult.H.Lines)*100)
		lineCoord = [Dataset.HoughResult.H.Lines(i).point1;
					 Dataset.HoughResult.H.Lines(i).point2];
		[myline,mycoords,outpIm,X,Y] = bresenham(inpIm, lineCoord, 0);
		ImH = ImH  + (1-outpIm);
	end

	if plotme
		fgLinesImV = figure();imshow(imdilate(ImV,ones(5,5)));
		fgLinesImH = figure();imshow(imdilate(ImH,ones(5,5)));
	end

