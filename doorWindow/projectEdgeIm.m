% load dataset if it doesnt exist
close all;
if false
if exist('Dataset.Houghresult')==0
	cd ..
	setup
	cd doorWindow
	main
	load('../dataset/Spil/SpilRect/Kbram.mat')
	%load('../dataset/Spil/SpilRect/WallsPc_SpilRect.mat')
	load('../mats/WallsPcSkew.mat');
end

wallNormal = getNormalFromWall(WallsPc, 1, 0)

zAxis = [0 0 1];
rotationVector = cross(zAxis, wallNormal)
angle = acos(dot(zAxis, wallNormal)) % could also be -R!!
R = getRotationMatrix(rotationVector, angle)

PcamAbs = [eye(3),[0 0 0]']


% initate black projected image
imEdgeProj = zeros(size(Dataset.ImReader.imEdge));

% search for coords where edge is 1
[Xedge,Yedge,dummy] = find(Dataset.ImReader.imEdge==1);
XYedge = [Xedge,Yedge];

XYproj = zeros(size(XYedge));
XYprojScaled = zeros(size(XYedge));

figure;hold on;
for i=1:length(XYedge)
	fprintf('\nprocent done %d', i/ length(XYedge) * 100)

	xy = [XYedge(i);1]
	[xyz1, dummy] = get3Dfrom2D(xy,1,PcamAbs,Kbram,WallsPc,1);
	%reproject to 2d
	XYproj(i,:) = homog22D(inv(R) * xyz1');
	plot(XYproj(i,1),XYproj(i,2),'+k')

end

end





if false

% scales up from example -3..1 to 0..1024
load('XYproj.mat');

Ymin = min(XYproj(:,1))
Xmin = min(XYproj(:,2))
Ymax = max(XYproj(:,1))
Xmax = max(XYproj(:,2))

% calc intervals and offsets
Xinterval = Xmax-Xmin
Yinterval = Ymax-Ymin
Offset = [-Ymin, -Xmin]
newResolution = [Dataset.ImReader.imHeight, Dataset.ImReader.imWidth]
Multiplier = newResolution ./ [Yinterval,Xinterval]
MultiplierRep = repmat(Multiplier,[length(XYproj),1]);
OffsetRep     = repmat(Offset,[length(XYproj),1]);


% add offset
XYprojScaled = XYproj + OffsetRep;
disp(' should be 0 ');
min(XYprojScaled(:,1))
min(XYprojScaled(:,2))

% do multiplier
XYprojScaled = XYprojScaled .* MultiplierRep

disp(' should be 1000 or so '); 
max(XYprojScaled(:,1))
max(XYprojScaled(:,2))

% add 1 to start at idx 1 (array indexing)
XYprojScaledRound = 1+round(XYprojScaled);



end


ImEdgeProj = zeros(newResolution);
ImEdgeProj(XYprojScaledRound(:,1), XYprojScaledRound(:,2)) = 1;

%%	ImEdgeProj(round(xyProj(1)), round(xyProj(2))) = 1;
figure;imshow(ImEdgeProj);

%see project2Normal/project2squareHough
