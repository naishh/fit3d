% click a line in 2d and project it to 3d
close all;
clear coord3dPrev

bScriptFirstTime=true;
if (bScriptFirstTime)
	load Walls
	load imgs
	%load outputVars_scriptComputeCameraMotion
	load Kcanon10GOOD
	load PcamScaled
end


% add homogenous coord
PcamAbs 		= normalizePcam(PcamScaled);
% inverses every item matrix in PcamAbs
PcamAbs 		= invertMotion(PcamAbs);
% make relative camera position absolute
PcamAbs 		= getTrajectory3DNorm(PcamAbs);



Ccs 			= PcamAbs(:,4,:);

% current image
imNr 			= 4;
%fixedWall 		= 10;
fixedWall 		= 7;

% get imgHeight
[imHeight,dummy,dummy2] = size(imgs{imNr});

% start figures
figPhoto = figure(); 
movegui(figPhoto, 'east');

% activate 3d model figure and show 3d model
fig3dModel = plotBuilding(Walls,[]);
movegui(fig3dModel, 'west');


mouseLeft = 3;
mouseButton = 1;

while(mouseButton~=mouseLeft)
	% activate photo window and show image
	figure(figPhoto); imshow(imgs{imNr});

	% click on figure
	[mouseX, mouseY, mouseButton]  	= ginput(1);
	%plot(mouseX,mouseY,'rx');

	% activate 3d model
	figure(fig3dModel);



	% TODO doesnt work, something with Ccs??
	% retriev proj line
	%projectionLine 		= getProjectionLine([mouseX, imHeight-mouseY]', Ccs, Kcanon10GOOD, PcamAbs, imNr);
	%projectionLine
	% plot short red projection line
	%plotProjectionLine(projectionLine, 'r-')

	%10 is front and then it increases clockwise
	[coord3d, wallNo]  	= get3Dfrom2D([mouseX, mouseY]', imNr, PcamAbs,Kcanon10GOOD, Walls, fixedWall) ;

	% plot short red projection line
	% plot long blue projection line till building
	plot3( [Ccs(1,1,imNr), coord3d(1)], [Ccs(2,1,2), coord3d(2)], [Ccs(3,1,3), coord3d(3)],'b-'); 

	if exist('coord3dPrev') ~= 0
		% draw 'hough' line
		coord3dPrev
		disp('drawing houghline')
		plot3( [coord3d(1),coord3dPrev(1)], [coord3d(2),coord3dPrev(2)], [coord3d(3),coord3dPrev(3)],'r-'); 
	end
	coord3dPrev = coord3d;
end

if (mouseButton == mouseLeft)
	simba
end

