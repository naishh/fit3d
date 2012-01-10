% this file does edge and houghline extraction
%
close all;
tic;

Dataset 						= getDataset('Spil');
plotme							= true;
edgeTest						= false;
paramStr 						= getParamStr(Dataset);

% read image
imOri = imread(Dataset.file);
im    = imOri;

% transform to e.g. HSV colormodel
im = getColorModelTransform(im, Dataset);

h = size(im,1);

fgBW = figure();imshow(im);

% EDGE TEST
if edgeTest
	for thresh=0.2:0.05:0.8
		thresh
		imEdge = im2double(edge(im, Dataset.EdgeDetectorParam.type, thresh));
		figure(round(thresh*100));
		imshow(imEdge);
	end
	error('edge test done, ending program')
end


% EDGE DETECTION 
imEdge = im2double(edge(im, Dataset.EdgeDetectorParam.type, Dataset.EdgeDetectorParam.thresh));
fgEdge = figure();imshow(imEdge);



% HOUGHLINES:
fgHough = figure();hold on

[H,Theta,Rho] = hough(imEdge,'Theta',Dataset.HoughParam.ThetaV.Start:Dataset.HoughParam.ThetaV.Resolution:Dataset.HoughParam.ThetaV.End);
Peaks  = houghpeaks(H,Dataset.HoughParam.nrPeaks,'threshold',ceil(Dataset.HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
Houghlines = houghlines(imEdge,Theta,Rho,Peaks,'FillGap',Dataset.HoughParam.fillGap,'MinLength',Dataset.HoughParam.minLength);

for k = 1:length(Houghlines)
	xy = [Houghlines(k).point1; Houghlines(k).point2];
	plotHoughline(xy, plotme,'green');
end


% HOUGHLINES ROTATED (HORIZONTAL):
imEdgeRot    = rot90(imEdge,-1);
[H,Theta,Rho] = hough(imEdgeRot,'Theta',Dataset.HoughParam.ThetaH.Start:Dataset.HoughParam.ThetaH.Resolution:Dataset.HoughParam.ThetaH.End);
Peaks  = houghpeaks(H,Dataset.HoughParam.nrPeaks,'threshold',ceil(Dataset.HoughParam.thresh*max(H(:))));
x = Theta(Peaks(:,2)); y = Rho(Peaks(:,1));
HoughlinesRot = houghlines(imEdgeRot,Theta,Rho,Peaks,'FillGap',Dataset.HoughParam.fillGap,'MinLength',Dataset.HoughParam.minLength);

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
	savePath 						= 'results/';
	% save images
	saveas(fgBW,[savePath,'result_raw__',paramStr],'png');
	saveas(fgEdge,[savePath,'result_edge__',paramStr],'png');
	saveas(fgHough,[savePath,'result_hough__',paramStr],'png');
	% update dataset vals
	Dataset.imOri			= imOri;
	Dataset.im 				= im;
	Dataset.imEdge 			= imEdge;
	Dataset.Houghlines 		= Houghlines;
	Dataset.HoughlinesRot 	= HoughlinesRot;
	save(['mats/Dataset_',Dataset.fileShort,'.mat'],'Dataset');
	disp('done');
end

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
