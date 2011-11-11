% simba is the new test platform for the pcamx bug
close all;
load Walls
load imgs
PcamAbs 		= getTrajectory3DNorm(invertMotion(normalizePcam(PcamX)));
Ccs 			= PcamAbs(:,4,:);
imNr 			= 1;


% start figures
figPhoto = figure(); figure(figPhoto);

[imHeight,dummy,dummy2] = size(imgs{imNr})

imshow(imgs{imNr});
% klik on figure
[mouseX, mouseY]  	= ginput(1)

figBuilding = plotBuilding(Walls,[]);



% retriev proj line
projectionLine 		= getProjectionLine([mouseX, imHeight-mouseY]', Ccs, Kcanon10GOOD, PcamAbs, imNr);
projectionLine
pause;

plotProjectionLine(projectionLine, 'r-')


fixedWall 			= 10;
% use formula to get xy3d , given a wall

[coord3d, wallNo]  	= get3Dfrom2D([mouseX, mouseY]', imNr, PcamAbs,Kcanon10GOOD, Walls, fixedWall) ;


plot3( [Ccs(1,1,imNr), coord3d(1)], [Ccs(2,1,2), coord3d(2)], [Ccs(3,1,3), coord3d(3)],'b-'); 

% draw line

% do projection algo

% plot and write cross in 3d model
