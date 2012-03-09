%close all;
figure;
load('Dataset_antwerpen_6223_crop1.mat');
%Houghlines = Dataset.HoughResult.Houghlines; HoughlinesRot = Dataset.HoughResult.HoughlinesRot
Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot

maxWindowSize = 200;
cornerInlierThreshold = 0.2

disp('getting cCorners..')
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold,maxWindowSize);



disp('plotting complete windows'); 
%plotcCorners(Houghlines, HoughlinesRot, 'cCornerConnectivitity',1)

interestingcCorners = [	1,1;
						9,1;
						47,2;
						56,4]


% tweak 
Houghlines(1).cCorners(1).hlineOri(1,1) = 35;
Houghlines(9).cCorners(1).hlineOri(1,1) = Houghlines(9).cCorners(1).hlineOri(1,1) + 10;
Houghlines(9).cCorners(1).hlineOri(2,2) = Houghlines(9).cCorners(1).hlineOri(2,1)
Houghlines(47).cCorners(2).hlineOri(1,1) = Houghlines(47).cCorners(2).hlineOri(1,1) + 20;
Houghlines(47).cCorners(2).hlineOri(2,2) = Houghlines(47).cCorners(2).hlineOri(2,1)
Houghlines(47).cCorners(2).vlineOri(2,2) = Houghlines(47).cCorners(2).vlineOri(2,2) - 100;
Houghlines(47).cCorners(2).crossing(2,1) = Houghlines(47).cCorners(2).hlineOri(2,1)

for idx=1:size(interestingcCorners,1);
	i=interestingcCorners(idx,1);
	k=interestingcCorners(idx,2);
	subplot(2,4,idx);
	plotcCorner(Houghlines(i).cCorners(k),'cCornerConnectivity',0); 
	axis square;
	subplot(2,4,idx+4);
	plotcCorner(Houghlines(i).cCorners(k),'cCornerCutoff' ,0);
	axis square;
end

disp('maxmize figure now!');
pause;

export_fig -eps cCornerTypes.eps


% i=1, k=1, plotcCorner(Houghlines(i).cCorners(k),plotMode,0); figure;
% i=9, k=1, plotcCorner(Houghlines(i).cCorners(k),plotMode,0); figure;
% i=47, k=2, plotcCorner(Houghlines(i).cCorners(k),plotMode,0); figure;
% i=56, k=4, plotcCorner(Houghlines(i).cCorners(k),plotMode,0); figure;
% close
