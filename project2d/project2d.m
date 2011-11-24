% this file transforms 3d coords of the building to a 2d image
close all;
load PcamAbs;	

load WallsImproved;
load WallsPc;
nWalls = length(WallsPc)/3;

load Kcanon10GOOD;

if exist('imgs') == 0
	%imgs = loadImgs(startPath,1,6);
	disp('loading images from images')
	%imgs = loadImgs(startPath, 5432 , 5470); 
	imgs = loadImgs(startPath, 5432 , 5439); 
else
	disp('loading images not needed');
end

%figBuilding = plotBuilding(Walls,[]);

% loop through different views
%for imNr=1:length(Houghlines2d)
for imNr=1:4
	figPhoto = figure();
	figure(figPhoto);
	imshow(imgs{imNr});
	hold on;

 	% plot improved 3d model
 	Walls = WallsImproved;
	for WallNr=1:nWalls
		i = 1;
		xAccu = zeros(nWalls,1);
		yAccu = zeros(nWalls,1);
		for pointNr=1:3:(length(Walls)-2)
			% get 3d corner coord of wall
			xy3D = [Walls(WallNr,pointNr),Walls(WallNr,pointNr+1), Walls(WallNr,pointNr+2)]';
			xy = get2Dfrom3D(xy3D, imNr, PcamAbs, Kcanon10GOOD);
			xAccu(i) = xy(1);
			yAccu(i) = xy(2);
			i = i + 1;
		end
		%change order
		xAccu = [xAccu(1),xAccu(2),xAccu(4),xAccu(3)];
		yAccu = [yAccu(1),yAccu(2),yAccu(4),yAccu(3)];
		plot(xAccu, yAccu, 'b-');
	end

	% plot basic 3d model
	Walls = WallsPc;
	for WallNr=1:nWalls
		i = 1;
		xAccu = zeros(nWalls,1);
		yAccu = zeros(nWalls,1);
		for pointNr=1:3:(length(Walls)-2)
			% get 3d corner coord of wall
			xy3D = [Walls(WallNr,pointNr),Walls(WallNr,pointNr+1), Walls(WallNr,pointNr+2)]';
			xy = get2Dfrom3D(xy3D, imNr, PcamAbs, Kcanon10GOOD);
			xAccu(i) = xy(1);
			yAccu(i) = xy(2);
			i = i + 1;
		end
		%change order
		xAccu = [xAccu(1),xAccu(2),xAccu(4),xAccu(3)];
		yAccu = [yAccu(1),yAccu(2),yAccu(4),yAccu(3)];
		plot(xAccu, yAccu, 'r-');
	end

end
