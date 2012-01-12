close all;

%load('../mats/Dataset_antwerpen6223_crop1.mat');
Houghlines = Dataset.Houghlines; HoughlinesRot = Dataset.HoughlinesRot

maxWindowSize = 200;
cornerInlierThreshold = 0.2
cCornerHarrisThreshold = 30; 
% cCornerHarrisThreshold =  cCornerHarrisThreshold * Dataset.projectionScale;
% disp('getting and plotting Harris corners..')
% plotme = 1; cornerScaleAccu = getHarrisCorners(plotme, Dataset.imColorModelTransform);
% plotCornerHarris(cornerScaleAccu,'g+');

% err
% % loop through Harris features and add evidence for close cCorners
% %disp('filtering on Harris corners..')
% %Houghlines = cCornerHarrisEvidence(Houghlines, cornerScaleAccu, 1, cCornerHarrisThreshold);
imshow(Dataset.imOri);hold on;

disp('getting cCorners..')
Houghlines = getcCorner(Houghlines,HoughlinesRot,cornerInlierThreshold,maxWindowSize);



disp('plotting complete windows'); 
plotcCorners(Houghlines, HoughlinesRot)

% project harris corners
%cornerScaleAccu = project2square(cornerScaleAccu,1,Dataset.HoughParam.projectionScale);


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

