% this file extract rectangles based on hough transform

% canny edge
% hough transform
% un blurr  or something to make lines thick
% sort by angle and play with angle intervals
%>calc min and max angle per wall by building outline
% select houghlines by angle
% sort hough on length houghline
% optional: crop building outline
% detect cornerpoints


plotme=1;
close all;
% imStartNr = 5432; imNr = 1; imNrFile = imNr - 1
% file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imStartNr + imNrFile)
% 
% imRGB = imread(file);
% imBW = imadjust(rgb2gray(imRGB));
% 
% % % GAUSSIAN BLUR
% % % todo checken of het wel nut heeft te blurren
% % s = fspecial('gaussian',5,5);
% % imBW=imfilter(imBW,s);
% % if bMatlabGui
% % 	figure; 
% % 	imshow(imBW);
% % end
% 
% save imBW

load imBW

% for thresh=0.05:0.05:1
% 	imEdge = im2double(edge(imBW, 'canny', thresh));
% 	figure(round(thresh*100));
% 	imshow(imEdge)
% 	pause;
% end

% crop image by rectangle
h = size(imBW,1);
w = size(imBW,2);
% coords derived by rounding
xCrop = [round(677.5000), round(885.5000)];
yCrop = [round(169.5000), round(707.5000)];
for y=1:h 
	for x=1:w
		% set values outside crop window to zero
		if (y<yCrop(1) || y>yCrop(2)) || (x<xCrop(1) || x>xCrop(2))
			imBW(y,x) = 0;
		end
	end
end
%figure; imshow(imBW)


% CANNY 
thresh=0.25
imEdge = im2double(edge(imBW, 'canny', thresh));
%imshow(imEdge);





%thresh = 0.2;
HoughParam.thresh = 0;
% sets the max nr of lines hough finds:
HoughParam.nrPeaks = 30;
HoughParam.fillGap = 10;
HoughParam.minLength = 20;

% HOUGHLINES:
[H,Theta,Rho] = hough(imEdge);
Peaks  = houghpeaks(H,HoughParam.nrPeaks,'threshold',ceil(HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
%TODO make minimum length depended of the width of the image
Houghlines = houghlines(imEdge,Theta,Rho,Peaks,'FillGap',HoughParam.fillGap,'MinLength',HoughParam.minLength);
if plotme
   figure,imshow(imEdge), hold on
end
max_len = 0;
length(Houghlines)


% verwoede poging om het in matrix form te fixen maar werkt niet..
%Houghlines.length = norm(Houghlines.point1-Houghlines.point2)


% plot houghlines and add length
% TODO Split plot and add length in 2 functions
Houghlines = plotHoughlines(Houghlines,plotme)




% FILTER HOUGHLINES

% wall 9? cornerpoints by hand
% 1---2
% |   |
% 4---3
X = [679.5000, 871.5000, 871.5000, 677.5000];
Y = [185.5000, 301.5000, 675.5000, 699.5000];
% height of the image
h = size(imBW,1);
theta1 = calcHoughTheta(X(1),Y(1),X(2),Y(2),h)
theta2 = calcHoughTheta(X(3),Y(3),X(4),Y(4),h)

if plotme
   figure,imshow(imEdge), hold on
end
for k = 1:length(Houghlines)
	% if houghline is in horizontal interval
	%if (Houghlines(k).theta<=theta1 && Houghlines(k).theta>=theta2)
	thetaH = Houghlines(k).theta;
	if thetaH>=theta1
		if thetaH<=theta2
			xy = [Houghlines(k).point1; Houghlines(k).point2];
			plotHoughline(xy, plotme)
		end
	end
end
