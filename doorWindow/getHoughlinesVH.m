% this file does edge and houghline extraction
%


fprintf('\nStarting Hough...');
close all;

if true
tic;
 
edgeFromCache					= false
saveImageQ						= true

plotme							= false;

% TODO BLUR
% TODO houghlines fillgab uitzetten in image



if plotme
	fgColorModelTransform = figure();imshow(Dataset.ImReader.imColorModelTransform);
	% plot min length line
	hold on; plot([10,10+Dataset.HoughParam.minLength],[10,10],'r-','LineWidth',2);
	fgEdge = figure();imshow(Dataset.ImReader.imEdge);
	% HOUGHLINES:
	fgHough = figure(); imshow(Dataset.ImReader.imOriDimmed); 
	hold on;
end


% HOUGHLINES VERTICAL:
[H,Theta,Rho] = hough(Dataset.ImReader.imEdge,'Theta',Dataset.HoughParam.ThetaV.Start:Dataset.HoughParam.ThetaV.Resolution:Dataset.HoughParam.ThetaV.End);
Peaks  = houghpeaks(H,Dataset.HoughParam.nrPeaks,'threshold',ceil(Dataset.HoughParam.thresh*max(H(:))));
HoughResult.Houghlines = houghlines(Dataset.ImReader.imEdge,Theta,Rho,Peaks,'FillGap',Dataset.HoughParam.fillGap,'MinLength',Dataset.HoughParam.minLength);
HoughResult.V.Theta = Theta;
HoughResult.V.Rho   = Rho;
HoughResult.V.Peaks = Peaks;
HoughResult.V.Lines = HoughResult.Houghlines;



% HOUGHLINES ROTATED (HORIZONTAL):
imEdgeRot    = rot90(Dataset.ImReader.imEdge,-1);
[H,Theta,Rho] = hough(imEdgeRot,'Theta',Dataset.HoughParam.ThetaH.Start:Dataset.HoughParam.ThetaH.Resolution:Dataset.HoughParam.ThetaH.End);
Peaks  = houghpeaks(H,Dataset.HoughParam.nrPeaks,'threshold',ceil(Dataset.HoughParam.thresh*max(H(:))));
HoughlinesRot = houghlines(imEdgeRot,Theta,Rho,Peaks,'FillGap',Dataset.HoughParam.fillGap,'MinLength',Dataset.HoughParam.minLength);
HoughResult.HoughlinesRot = flipHoughlinesRot(HoughlinesRot, Dataset.ImReader.imHeight);
HoughResult.H.Theta = Theta;
HoughResult.H.Rho = Rho;
HoughResult.H.Peaks = Peaks;
HoughResult.H.Lines = HoughResult.HoughlinesRot;

%HOUGHLINES PLOT
plotHoughlinesAll(Dataset.ImReader.imHeight,HoughResult.Houghlines,HoughResult.HoughlinesRot)

end

% TODO--------------------------------------------------------------------------------------------
disp('press key to rectify and plot houghlines..')
pause;
plotHoughlinesAll(Dataset.ImReader.imHeight,HoughResult.Houghlines,HoughResult.HoughlinesRot)
figure;
Dataset.HoughResult = rectifyHoughlines(HoughResult, H)
plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.HoughlinesRect,Dataset.HoughResult.HoughlinesRotRect)


if plotme
	disp('saving images ..');
	savePathFile 						= ['results/',Dataset.fileShort];
	saveas(fgColorModelTransform,[savePathFile,'_colortransform__',Dataset.paramStr],'png');
	saveas(fgEdge,[savePathFile,'_edge__',Dataset.paramStr],'png');
	saveas(fgHough,[savePathFile,'_hough__',Dataset.paramStr],'png');
end


disp('saving dataset..');
% update dataset vals
saveStr = [startPath,'/doorWindow/mats/Dataset_',Dataset.fileShort,'_HoughResult.mat'];
save(saveStr, 'HoughResult');
saveStr, disp('saved');

fprintf(' [DONE]\n');
toc;


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
