%close all;
if isfield(Dataset,'Imreader')==0
	cd ../..
	%load('dataset/Spil/SpilRect/Kbram.mat');K=Kbram
	load('dataset/FloriandeSet1/KCanon10mm.mat');K=Kcanon10GOOD
	setup
	cd doorWindow
	%Dataset = getDataset('Spil4BigOutline',startPath)
	%Dataset = getDataset('Floriande0',startPath)
	Dataset = getDataset('Floriande0Outline',startPath)
	figure; imshow(Dataset.ImReader.imColorModelTransform)
	cd projection
	% load map
	load('planeFitter/MAPfloriande.mat'); 
end
%load('../../mats/WallsPcMiddle2.mat')
%adjust Z
%WallsPc(1,9)= WallsPc(1,9)+0.5;
%WallsPc(1,12)= WallsPc(1,12)+0.5;

% get wall from point cloud

WallsPc 	= getWallFromPc(MAP);
wallNormal  = getNormalFromWall(WallsPc, 1, 0)


zAxis = [0 0 1];
rotationVector = cross(zAxis, wallNormal)
angle = acos(dot(zAxis, wallNormal)) % could also be -R!!
R = getRotationMatrix(rotationVector, angle)

PcamAbs = [eye(3),[0 0 0]']

% initate black projected image
imEdgeProj = zeros(size(Dataset.ImReader.imEdge));

% search for coords where edge is 1
% todo instead of rot flip x with y?
[Yedge,Xedge,dummy] = find(Dataset.ImReader.imEdge==1);
XYedge = [Xedge,Yedge];

XYproj = zeros(size(XYedge));
XYprojScaled = zeros(size(XYedge));

figure;hold on;
len = length(XYedge);
for i=1:1:len
	fprintf('\nprocent done %d', round(i/ length(XYedge) * 100))

	%xy = [XYedge(i,:)';1]
	xy = [XYedge(i,:),1];
	[xyz1, dummy] = get3Dfrom2D(xy,1,PcamAbs,K,WallsPc,1);
	%reproject to 2d
	XYproj(i,:) = homog22D(inv(R) * xyz1');
	%XYproj(i,:)

	plot(XYproj(i,1), -XYproj(i,2),'.k','MarkerSize',1)

	%XYprojScaled = XYproj + OffsetRep;
	%XYprojScaled = XYprojScaled .* MultiplierRep
end

axis equal;




if false

% scales up from example -3..1 to 0..1024
%load('XYproj.mat');

Ymin = min(XYproj(:,1))
Xmin = min(XYproj(:,2))
Ymax = max(XYproj(:,1))
Xmax = max(XYproj(:,2))

load('upscaleVars.mat');

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

save('upscaleVars.mat','Xmin','Ymin','Xmax','Xmin','Multiplier','Offset')


ImEdgeProj = zeros(newResolution);
for i=1:length(XYprojScaledRound)
	i/length(XYprojScaledRound)*100
	ImEdgeProj(XYprojScaledRound(i,1), XYprojScaledRound(i,2)) = 1;
end
%ImEdgeProj(XYprojScaledRound(:,1), XYprojScaledRound(:,2)) = 1;

%%	ImEdgeProj(round(xyProj(1)), round(xyProj(2))) = 1;
figure;imshow(ImEdgeProj);

end
