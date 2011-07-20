% simba is the new test platform
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

plotProjectionLine(projectionLine, 'r-')


fixedWall 			= 10;
% use formula to get xy3d , given a wall

[coord3d, wallNo]  	= get3Dfrom2D([mouseX, mouseY]', imNr, PcamAbs,Kcanon10GOOD, Walls, fixedWall) ;


plot3( [Ccs{imNr}(1), coord3d(1)], [Ccs{imNr}(2), coord3d(2)], [Ccs{imNr}(3), coord3d(3)],'r-'); 

% draw line

% do projection algo

% plot and write cross in 3d model
