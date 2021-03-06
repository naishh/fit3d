% turns houghlines into pixel images 
function [LinesImV,LinesImH] = houghlinesToImOrt(Dataset, plotme)
	close all;	
disp('plotting houghlines');
	%fgHough = figure();imshow(Dataset.ImReader.imOriDimmed); hold on;
	%plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot);
	% %im = hough_bin_pixels(Dataset.ImReader.imEdge, HoughlinesObj.Theta,HoughlinesObj.Rho,HoughlinesObj.Peaks(1,:));

	% imTotal=zeros(Dataset.ImReader.imHeight,Dataset.ImReader.imWidth);
	% for p=1:size(HoughlinesObj.Peaks,1)
	% 	im = hough_bin_pixels(Dataset.ImReader.imEdge, HoughlinesObj.Theta,HoughlinesObj.Rho,HoughlinesObj.Peaks(p,:));
	% 	imTotal = imTotal + im;
	% 	p
	% end
	% imshow(imTotal,[]);
	% TODO alles buiten endpoints van houghlines  weggooien
	% http://blogs.mathworks.com/steve/2006/09/01/showing-image-pixels-associated-with-a-hough-transform-bin/


	Houghlines = Dataset.HoughResult.V.Lines;
	LinesImV = zeros(Dataset.ImReader.imHeight,Dataset.ImReader.imWidth);
	for i=1:length(Houghlines)
		x1 = Houghlines(i).point1(1);
		x2 = Houghlines(i).point2(1);
		y1 = Houghlines(i).point1(2);
		y2 = Houghlines(i).point2(2);
		avgX = round((x1 + x2)/ 2);
		%LinesImV(y1:y2,avgX-5:avgX+5) = 1;
		LinesImV(y1:y2,avgX) = 1;
	end

	Houghlines = Dataset.HoughResult.H.Lines;
	LinesImH = zeros(Dataset.ImReader.imHeight,Dataset.ImReader.imWidth);
	for i=1:length(Houghlines)
		x1 = Houghlines(i).point1(1);
		x2 = Houghlines(i).point2(1);
		y1 = Houghlines(i).point1(2);
		y2 = Houghlines(i).point2(2);
		avgY = round((y1 + y2)/ 2);
		LinesImH(avgY,x1:x2) = 1;
	end

	if plotme
		fgLinesImV = figure();imshow(imdilate(LinesImV,ones(5,5)));
		fgLinesImH = figure();imshow(imdilate(LinesImH,ones(5,5)));
		%figure;imshow(imdilate(LinesImV,ones(5,5))+imdilate(LinesImH,ones(5,5)),[]);
	end

