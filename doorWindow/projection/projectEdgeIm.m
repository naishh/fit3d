% todo save edge projected in dataset
zAxis = [0 0 1];
rotationVector = cross(zAxis, Dataset.Projection.wallNormal)
angle = acos(dot(zAxis, Dataset.Projection.wallNormal)) % could also be -R!!
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
	[xyz1, dummy] = get3Dfrom2D(xy,1,PcamAbs,Dataset.Projection.K,Dataset.Projection.WallsPc,1);
	%reproject to 2d
	XYproj(i,:) = homog22D(inv(R) * xyz1');
	%XYproj(i,:)

	plot(XYproj(i,1), -XYproj(i,2),'.k','MarkerSize',1)

	%XYprojScaled = XYproj + OffsetRep;
	%XYprojScaled = XYprojScaled .* MultiplierRep
end

axis equal;




