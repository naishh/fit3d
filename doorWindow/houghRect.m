% this file extract rectangles based on hough transform
%
% compose mail to frans with results send on sunday
% other dataset
% a priori theta ratio 
	% for vertical and horizontal lines differently
% perform hough on rotated image
% unrotate results
% set results in unrotated image

% houghlines must be spread
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


close all;
tic;
%imNr = 5447; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr);
%load('XYangleFilter_floriande_5447.mat');
%file = sprintf('../dataset/datasetSpil/datasetSpilRect/P_rect6.jpg')
imNr = 6680; file = sprintf('../dataset/fullDatasets/aalsmeer/undist__MG_%d.jpg', imNr);
load('XYangleFilter_aalsmeer6680.mat');


plotme							= 1;
savePath 						= 'results/';
fileShort 						= 'aalsmeer6680';
colorModel						= 'HSV_Vchannel';
%colorModel						= 'RGB';
HSVmode							= true;
transposeMode 					= true;
edgeDetectorParam.type 			= 'canny';
loadEdgeFromCache 				= false;
%edgeDetectorParam.typePost 		= 'vertical_horizontal_Combined';
edgeDetectorParam.typePost 		= '';
%edgeDetectorParam.thresh		= 0.50;%0.45
edgeDetectorParam.thresh		= 0.4;%0.45
% perform different threshold test?
edgeTest 						= 0;
HoughParam.thresh 				= 0;
% sets the max nr of lines hough finds:
HoughParam.nrPeaks 				= 150;
%HoughParam.fillGap 			= 30;
% the bigger this value the more lines are found
HoughParam.fillGap 				= 30;

% select smallest windowglas width from left to right
%[Xwin,Ywin] = ginput(2); XYwin1 = [Xwin(1),Ywin(1)]; XYwin2 = [Xwin(2),Ywin(2)];norm(XYwin1,XYwin2)
HoughParam.minLength 			= 55; 
vertAngleOffset 				= 0;
% this is the maximum error that a vertical line can have
maxVertAngleErr 				= 15;

% todo transfer to sprintf 
paramStr = ['src_',fileShort,'_colorModel_',colorModel,'__edgeDetectorParams_',edgeDetectorParam.type,edgeDetectorParam.typePost,'_thresh_',num2str(edgeDetectorParam.thresh),'__HoughParams_', 'thresh_',num2str(HoughParam.thresh) , '_nrPeaks_',num2str(HoughParam.nrPeaks) , '_fillGap_',num2str(HoughParam.fillGap) , '_minLength_',num2str(HoughParam.minLength),'__maxVertAngleErr_',num2str(maxVertAngleErr),'.png'];

if loadEdgeFromCache == false
	imRGB = imread(file);
	if(HSVmode)
		imHSV = rgb2hsv(imRGB);
		%imBW  = imHSV(:,:,3);
		if transposeMode == true
			disp('transposeMode');
			imBW  = imHSV(:,:,3)';
		else
			imBW  = imHSV(:,:,3);
		end
		%fgRGB = figure();imshow(imHSV);
	else
		%imBW = imRGB(:,:,3);
		imBW = imadjust(rgb2gray(imRGB));
		%fgRGB = figure();imshow(imRGB);
	end
	fgBW = figure();imshow(imBW);
end


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
	for thresh=0.1:0.05:0.8
		thresh
		imEdge = im2double(edge(imBW, edgeDetectorParam.type, thresh));
		figure(round(thresh*100));
		imshow(imEdge)
	end
	error('edge test done, ending program')
end

% EDGE DETECTION 
if loadEdgeFromCache == false
	imEdge = im2double(edge(imBW, edgeDetectorParam.type, edgeDetectorParam.thresh));
	%imEdge = im2double(edge(imBW, edgeDetectorParam.type, edgeDetectorParam.thresh, 'vertical'));
end
if plotme
   fgEdge = figure();imshow(imEdge);
end



% HOUGHLINES:
%[H,Theta,Rho] = hough(imEdge,'Theta', -20:0.5:-1 );
% het gaat fout als je interval over het omrolpunt beslaat -90 % ,quickfix is checken of het bij omslagpunt ligt, % indien ja imEdge 90 graden draaien en hough op verschoven interval uitvoeren
% hmm is er niet een equivalent die +180 is? nee...
[H,Theta,Rho] = hough(imEdge,'Theta',-9:0.5:12);

Peaks  = houghpeaks(H,HoughParam.nrPeaks,'threshold',ceil(HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
Houghlines = houghlines(imEdge,Theta,Rho,Peaks,'FillGap',HoughParam.fillGap,'MinLength',HoughParam.minLength);
Houghlines = addLengthToHoughlines(Houghlines);
if plotme
   fgHough = figure();imshow(imEdge);hold on
end
max_len = 0;


% FILTER HOUGHLINES
% 1---2
% |   |
% 4---3
% '../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', 5432
% X = [679.5000, 871.5000, 871.5000, 677.5000];
% Y = [185.5000, 301.5000, 675.5000, 699.5000];
% use [X,Y] =  ginput(4) and store XY in a mat format

% TODO calc wallVanishesRight val automaticly (crossing the building horizontal edges and check if its right or left from center of image?)
wallVanishesRight = true;

% calculates the angle of the upper and bottom wallline segment
% (in orde to provide the angle interval)
h = size(imBW,1);
theta1 = calcHoughTheta(X(1),Y(1),X(2),Y(2),h)
theta2 = calcHoughTheta(X(3),Y(3),X(4),Y(4),h)

if transposeMode == true
	% rotate 90 degrees
	theta1 = theta1+90
	theta2 = theta2+90
	vertAngleOffset = vertAngleOffset + 90;
end

for k = 1:length(Houghlines)
	% if houghline is in horizontal interval
	thetaH = Houghlines(k).theta;

	xy = [Houghlines(k).point1; Houghlines(k).point2];
	plotHoughline(xy, plotme,'yellow')

	if wallVanishesRight 
		% if is in interval
		% HORIZONTAL
		if thetaH<=theta1 && thetaH>=theta2 % todo this doesnt work for vars that are below -90 ! 
			xy = [Houghlines(k).point1; Houghlines(k).point2];
			plotHoughline(xy, plotme,'red')
		end
		% VERTICAL
		if (thetaH>=vertAngleOffset-maxVertAngleErr && thetaH<=vertAngleOffset+maxVertAngleErr )
			xy = [Houghlines(k).point1; Houghlines(k).point2];
			plotHoughline(xy, plotme,'green')
		end
	end
	% TODO treat vanishleft case
	% else
	% end
end


toc;
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
