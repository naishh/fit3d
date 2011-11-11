% simba is the new test platform for the pcamx bug
close all;

bScriptFirstTime=false
if (bScriptFirstTime)
	load Walls
	load imgs
	load outputVars_scriptComputeCameraMotion
end

PcamAbs 		= getTrajectory3DNorm(invertMotion(normalizePcam(PcamX)));
Ccs 			= PcamAbs(:,4,:);

% current image
imNr 			= 4;
fixedWall 		= 10;

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
end

if (mouseButton == mouseLeft)
	simba
end

