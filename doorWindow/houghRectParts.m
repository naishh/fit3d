% this file extract rectangles based on hough transform
%
% new plan
% transform edge image to rectangular image
%	apply hough rectangul detection based on hough transform (paper)
% make dummy image where some rectangles are present
% unblurr or something like that to make edgelines more thick
% apply a houghline length range (max and min), 
% use a height-width ratio for windows
% detect cornerpoints by houghline intersection
% 	detect exact intersections
% 	stretch exact intersection by making all lines just a little bit longer
%		search old paper for auto connect line parts
% play with a (harris?) cornerdetector
% read paper about implicite shape of window
%	use assumptions, like average width height ratio of the window


close all;
tic;
imNr = 5435; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); load('XYangleFilter_floriande_5447.mat'); load('XYcropRegionFloriande5435.mat'); edgeDetectorParam.thresh		= 0.55; HoughParam.ThetaH.StretchAngle	= 30;HoughParam.ThetaV.StretchAngle	= 10;
%imNr = 5447; file = sprintf('../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', imNr); 
%	load('XYangleFilter_floriande_5447.mat'); 
%	load('XYcropRegionFloriande5447.mat'); 
%	edgeDetectorParam.thresh		= 0.35; 
%	HoughParam.ThetaH.StretchAngle	= 30;
%	HoughParam.ThetaV.StretchAngle	= 10;
%imNR = 6; file = sprintf('../dataset/datasetSpil/datasetSpilRect/P_rect6.jpg')
% imNr = 6680; file = sprintf('../dataset/fullDatasets/aalsmeer/undist__MG_%d.jpg', imNr); load('XYangleFilter_aalsmeer6680.mat');


plotme							= 1;
savePath 						= 'results/';
%fileShort 						= 'aalsmeer6680';
fileShort 						= 'floriande5447';
colorModel						= 'HSV_Vchannel';
%colorModel						= 'RGB';
HSVmode							= true;
% rotates image 90 degrees clockwise
edgeDetectorParam.type 			= 'canny';
loadEdgeFromCache 				= 0;
%edgeDetectorParam.typePost 		= 'vertical_horizontal_Combined';
edgeDetectorParam.typePost 		= '';
% perform different threshold test?
edgeTest 						= 0;
HoughParam.ThetaV.Start 		= 0;
HoughParam.ThetaV.Start 		= HoughParam.ThetaV.Start - HoughParam.ThetaV.StretchAngle;
HoughParam.ThetaH.Start 		= 0;
HoughParam.ThetaH.Start 		= HoughParam.ThetaH.Start - HoughParam.ThetaH.StretchAngle;
HoughParam.ThetaH.End 			= 0;
HoughParam.ThetaH.End 			= HoughParam.ThetaH.End + HoughParam.ThetaH.StretchAngle;
HoughParam.ThetaV.End 			= 0;
HoughParam.ThetaV.End 			= HoughParam.ThetaV.End + HoughParam.ThetaV.StretchAngle;
HoughParam.ThetaH.Resolution  	= 0.5;
HoughParam.ThetaV.Resolution  	= HoughParam.ThetaH.Resolution;
HoughParam.thresh 				= 0;
% sets the max nr of lines hough finds:
HoughParam.nrPeaks 				= 200;
%HoughParam.fillGap 			= 30;
% the bigger this value the more lines are found
HoughParam.fillGap 				= 10;

% select smallest windowglas width from left to right
%[Xwin,Ywin] = ginput(2); XYwin1 = [Xwin(1),Ywin(1)]; XYwin2 = [Xwin(2),Ywin(2)];norm(XYwin1,XYwin2)
HoughParam.minLength 			= 45; 

% todo transfer to sprintf 
paramStr = ['src_',fileShort,'_colorModel_',colorModel,'__edgeDetectorParams_',edgeDetectorParam.type,edgeDetectorParam.typePost,'_thresh_',num2str(edgeDetectorParam.thresh),'__HoughParams_', 'thresh_',num2str(HoughParam.thresh) , '_nrPeaks_',num2str(HoughParam.nrPeaks) , '_fillGap_',num2str(HoughParam.fillGap) , '_minLength_',num2str(HoughParam.minLength),'__ThetaRangeH_',num2str(HoughParam.ThetaH.Start),':',num2str(HoughParam.ThetaH.Resolution),':',num2str(HoughParam.ThetaH.End),'_ThetaRangeV_',num2str(HoughParam.ThetaV.Start),':',num2str(HoughParam.ThetaV.Resolution),':',num2str(HoughParam.ThetaV.End),'.png'];

if loadEdgeFromCache == false
	imRGB = imread(file);
	if(HSVmode)
		imHSV = rgb2hsv(imRGB);
		imBW     = imHSV(:,:,3);
	else
		%imBW = imRGB(:,:,3);
		imBW = imadjust(rgb2gray(imRGB));
		%fgRGB = figure();imshow(imRGB);
	end
end


imBW = cropImage(imBW, X,Y);
h = size(imBW,1);
fgBW = figure();imshow(imBW);

if edgeTest
	for thresh=0.2:0.05:0.8
		thresh
		imEdge = im2double(edge(imBW, edgeDetectorParam.type, thresh));
		figure(round(thresh*100));
		imshow(imEdge);
	end
	error('edge test done, ending program')
end

% EDGE DETECTION 
if loadEdgeFromCache == false
	imEdge = im2double(edge(imBW, edgeDetectorParam.type, edgeDetectorParam.thresh));
end
fgEdge = figure();imshow(imEdge);



fgHough = figure();imshow(imEdge);hold on

% HOUGHLINES:
[H,Theta,Rho] = hough(imEdge,'Theta',HoughParam.ThetaV.Start:HoughParam.ThetaV.Resolution:HoughParam.ThetaV.End);
Peaks  = houghpeaks(H,HoughParam.nrPeaks,'threshold',ceil(HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
Houghlines = houghlines(imEdge,Theta,Rho,Peaks,'FillGap',HoughParam.fillGap,'MinLength',HoughParam.minLength);
Houghlines = addLengthToHoughlines(Houghlines);

for k = 1:length(Houghlines)
	xy = [Houghlines(k).point1; Houghlines(k).point2];
	plotHoughline(xy, plotme,'green')
end


% HOUGHLINES ROTATED (HORIZONTAL):
if loadEdgeFromCache == false
	imEdgeRot    = rot90(imEdge,-1);
end
[H,Theta,Rho] = hough(imEdgeRot,'Theta',HoughParam.ThetaH.Start:HoughParam.ThetaH.Resolution:HoughParam.ThetaH.End);
Peaks  = houghpeaks(H,HoughParam.nrPeaks,'threshold',ceil(HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
HoughlinesRot = houghlines(imEdgeRot,Theta,Rho,Peaks,'FillGap',HoughParam.fillGap,'MinLength',HoughParam.minLength);
HoughlinesRot = addLengthToHoughlines(HoughlinesRot);

for k = 1:length(HoughlinesRot)
	% TODO get xy from Theta(..) above, calc as matrix
	xy = [invertCoordFlipY(HoughlinesRot(k).point1,h); invertCoordFlipY(HoughlinesRot(k).point2,h)];
	% save inverted coord on HoughlinesRot
	HoughlinesRot(k).point1 = xy(1,:); HoughlinesRot(k).point2 = xy(2,:);
	plotHoughline(xy, plotme,'red')
end


toc;
reply = input('Save result as images? y/n [n]: ', 's');
if isempty(reply)
	reply = 'n';
end
if reply=='y'
	disp('saving images..');
	% save images
	saveas(fgBW,[savePath,'result_raw__',paramStr],'png');
	saveas(fgEdge,[savePath,'result_edge__',paramStr],'png');
	saveas(fgHough,[savePath,'result_hough__',paramStr],'png');
	save(['mats/Houghlines_',fileShort,'.mat'],'Houghlines');
	save(['mats/HoughlinesRot_',fileShort,'.mat'],'HoughlinesRot');
	disp('done');
end



% OLD CODE:
%
% FILTER HOUGHLINES
% 1---2
% |   |
% 4---3
% '../dataset/FloriandeSet1/medium/undist__MG_%d.jpg', 5432
% X = [679.5000, 871.5000, 871.5000, 677.5000];
% Y = [185.5000, 301.5000, 675.5000, 699.5000];
% use [X,Y] =  ginput(4) and store XY in a mat format
% calculates the angle of the upper and bottom wallline segment
% (in orde to provide the angle interval)
% theta1 = calcHoughTheta(X(1),Y(1),X(2),Y(2),h)
% theta2 = calcHoughTheta(X(3),Y(3),X(4),Y(4),h)
