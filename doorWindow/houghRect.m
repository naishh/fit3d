% this file extract rectangles based on hough transform
%
% compose mail to frans with results send on sunday
% other colormodel, derivative image, prewitt
% other colormodel, rgb independend channels
% horizontal and vertical image different edgemethod/thresholds 
% other dataset
% unblurr or something like that to make edgelines more thick
% apply a houghline length range (max and min), 
% use a height-width ratio for windows
% transform edge image to rectangular image
% detect cornerpoints by houghline intersection
% 	detect exact intersections
% 	stretch exact intersection by making all lines just a little bit longer
%		search old paper for auto connect line parts
% play with a (harris?) cornerdetector
% read paper about implicite shape of window
%	use assumptions, like average width height ratio of the window
%
% report: say something about angle interval that should depend on height in image but doesnt


plotme=1;
close all;
imNr = 5447; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr);
savePath = 'results/';

fileShort 						= 'Floriande5447';
colorModel						= 'RGB_Bchannel';
%colorModel						= 'HSV_Allchannel';
edgeDetectorParam.type 			= 'canny';
%edgeDetectorParam.typePost 		= 'vertical_horizontal_Combined';
edgeDetectorParam.typePost 		= '';
%edgeDetectorParam.thresh		= 0.50;%0.45
edgeDetectorParam.thresh		= 0.5;%0.45
% perform different threshold test?
edgeTest 						= 0;
HoughParam.thresh 				= 0;
% sets the max nr of lines hough finds:
HoughParam.nrPeaks 				= 500;
%HoughParam.fillGap 			= 30;
HoughParam.fillGap 				= 15;
HoughParam.minLength 			= 20; 
% this is the maximum error that a vertical line can have
maxVertAngleErr 				= 5;

% todo transfer to sprintf 
paramStr = ['src_',fileShort,'_colorModel_',colorModel,'__edgeDetectorParams_',edgeDetectorParam.type,edgeDetectorParam.typePost,'_thresh_',num2str(edgeDetectorParam.thresh),'__HoughParams_', 'thresh_',num2str(HoughParam.thresh) , '_nrPeaks_',num2str(HoughParam.nrPeaks) , '_fillGap_',num2str(HoughParam.fillGap) , '_minLength_',num2str(HoughParam.minLength),'__maxVertAngleErr_',num2str(maxVertAngleErr),'.png'];

imRGB = imread(file);


%imHSV = rgb2hsv(imRGB);

fgRGB = figure();imshow(imRGB);
%fgRGB = figure();imshow(imHSV);

%imBW = imadjust(rgb2gray(imRGB));
imBW = imRGB(:,:,3);

fgBW = figure();imshow(imBW);
% 
%load imBW
%file = sprintf('../dataset/datasetSpil/datasetSpilRect/P_rect6.jpg')
%imBW = imread(file);
%load imBW_spil_6


%  % crop image by rectangle
% TODO make this crop function in .m file
%  h = size(imBW,1);
%  w = size(imBW,2);
%  % coords derived by rounding
%  xCrop = [round(677.5000), round(885.5000)];
%  yCrop = [round(169.5000), round(707.5000)];
%  for y=1:h 
%  	for x=1:w
%  		% set values outside crop window to zero
%  		if (y<yCrop(1) || y>yCrop(2)) || (x<xCrop(1) || x>xCrop(2))
%  			imBW(y,x) = 0;
%  		end
%  	end
%  end
%  %figure; imshow(imBW)


if edgeTest
	for thresh=0.1:0.02:0.6
		thresh
		imEdge = im2double(edge(imBW, edgeDetectorParam.type, thresh));
		figure(round(thresh*100));
		imshow(imEdge)
		pause;
	end
	error('edge test done, ending program')
end

% EDGE DETECTION 
imEdge = im2double(edge(imBW, edgeDetectorParam.type, edgeDetectorParam.thresh));
%imEdge = im2double(edge(imBW, edgeDetectorParam.type, edgeDetectorParam.thresh, 'vertical'));
if plotme
   fgEdge = figure();imshow(imEdge);
end



% theta1 = -71.8234
% theta2 = -95.8395

% HOUGHLINES:
%[H,Theta,Rho] = hough(imEdge,'Theta', -20:0.5:-1 );
% het gaat fout als je interval over het omrolpunt beslaat -90
% quickfix is checken of het bij omslagpunt ligt
% indien ja imEdge 90 graden draaien en hough op verschoven interval uitvoeren
%[H,Theta,Rho] = hough(imEdge,'Theta', -90:0.5:-70 );
[H,Theta,Rho] = hough(imEdge);
Peaks  = houghpeaks(H,HoughParam.nrPeaks,'threshold',ceil(HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
%TODO make minimum length depended of the width of the image
Houghlines = houghlines(imEdge,Theta,Rho,Peaks,'FillGap',HoughParam.fillGap,'MinLength',HoughParam.minLength);
if plotme
   fgHough = figure();imshow(imEdge);hold on
end
max_len = 0;
length(Houghlines)



% verwoede poging om het in matrix form te fixen maar werkt niet..
%Houghlines.length = norm(Houghlines.point1-Houghlines.point2)


% plot houghlines and add length
% TODO Split plot and add length in 2 functions

%Houghlines = plotHoughlines(Houghlines);
Houghlines = addLengthToHoughlines(Houghlines);





% FILTER HOUGHLINES

% wall 9? cornerpoints by hand
% 1---2
% |   |
% 4---3
% '../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', 5432
% X = [679.5000, 871.5000, 871.5000, 677.5000];
% Y = [185.5000, 301.5000, 675.5000, 699.5000];
% height of the image

%[X,Y] =  ginput(4)
load('XYangleFilter_floriande_5447.mat');
% TODO calc this val automaticly (crossing the building horizontal edges and check if its right or left from center of image?)
wallVanishesRight = true;
h = size(imBW,1);
theta1 = calcHoughTheta(X(1),Y(1),X(2),Y(2),h)
theta2 = calcHoughTheta(X(3),Y(3),X(4),Y(4),h)

for k = 1:length(Houghlines)
	% if houghline is in horizontal interval
	%if (Houghlines(k).theta<=theta1 && Houghlines(k).theta>=theta2)
	thetaH = Houghlines(k).theta;
	if wallVanishesRight % this only works is for a wall which vanishish to the right >
		% if is in interval
		% HORIZONTAL
		if thetaH<=theta1 && thetaH>=theta2 % todo this doesnt work for vars that are below -90 ! 
			xy = [Houghlines(k).point1; Houghlines(k).point2];
			plotHoughline(xy, plotme,'red')
		end
		% VERTICAL
		if (thetaH>=-maxVertAngleErr && thetaH<=maxVertAngleErr )
			xy = [Houghlines(k).point1; Houghlines(k).point2];
			plotHoughline(xy, plotme,'green')
		end
	end
end



% load('HoughlinesPrewittHor')
% for k = 1:length(Houghlines)
% 	% if houghline is in horizontal interval
% 	%if (Houghlines(k).theta<=theta1 && Houghlines(k).theta>=theta2)
% 	thetaH = Houghlines(k).theta;
% 	if wallVanishesRight % this only works is for a wall which vanishish to the right >
% 		% if is in interval
% 		% HORIZONTAL
% 		if thetaH<=theta1 && thetaH>=theta2 % todo this doesnt work for vars that are below -90 ! 
% 			xy = [Houghlines(k).point1; Houghlines(k).point2];
% 			plotHoughline(xy, plotme,'red')
% 		end
% 		% % VERTICAL
% 		% if (thetaH>=-maxVertAngleErr && thetaH<=maxVertAngleErr )
% 		% 	xy = [Houghlines(k).point1; Houghlines(k).point2];
% 		% 	plotHoughline(xy, plotme,'green')
% 		% end
% 	end
% end


reply = input('Save result as images? y/n [n]: ', 's');
if isempty(reply)
	reply = 'n';
end
if reply=='y'
	disp('saving images..');
	% save images
	saveas(fgRGB,[savePath,'result_raw__',paramStr],'png');
	saveas(fgEdge,[savePath,'result_edge__',paramStr],'png');
	saveas(fgHough,[savePath,'result_hough__',paramStr],'png');
	disp('done');
end
