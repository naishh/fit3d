close all;

Dataset 						= getDataset('Spil');
Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot

cornerInlierThreshold = 0.2
maxWindowSize = 200;

cCornerHarrisThreshold = 30; 
cCornerHarrisThreshold =  cCornerHarrisThreshold * projectionScale;



disp('getting and plotting Harris corners..')
plotme = 1; cornerScaleAccu = getHarrisCorners(plotme, im);
err
% loop through Harris features and add evidence for close cCorners
%disp('filtering on Harris corners..')
%Houghlines = cCornerHarrisEvidence(Houghlines, cornerScaleAccu, 1, cCornerHarrisThreshold);

disp('getting cCorners..')
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold,maxWindowSize);



disp('plotting complete windows'); 
plotcCorners(Houghlines, HoughlinesRot)

% project harris corners
%cornerScaleAccu = project2square(cornerScaleAccu,1,Dataset.HoughParam.projectionScale);
%plotCornerHarris(cornerScaleAccu,'g+');


%reply = input('Save result as images? y/n [n]: ', 's');
%if isempty(reply)
%	reply = 'n';
%end
%if reply=='y'
%	disp('saving images..');
%	% save images
%	saveas(fg,['resultsWindow/doorWindow_',paramStr],'png');
%	disp('done');
%end

