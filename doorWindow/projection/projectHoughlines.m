plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.Houghlines,Dataset.HoughResult.HoughlinesRot)

zAxis = [0 0 1];
rotationVector = cross(zAxis, Dataset.Projection.wallNormal)
angle = acos(dot(zAxis, Dataset.Projection.wallNormal)) % could also be -R!!
R = getRotationMatrix(rotationVector, angle)

PcamAbs = [eye(3),[0 0 0]']

Dataset.HoughResult.HoughlinesProj = Dataset.HoughResult.Houghlines
for k = 1:length(Dataset.HoughResult.Houghlines)
	k
	xy1 = Dataset.HoughResult.Houghlines(k).point1';
	xy2 = Dataset.HoughResult.Houghlines(k).point2';
	% project to 3d
	% TODO MAYBE IT IS IMAGE 4
	[xyz1, dummy] = get3Dfrom2D(xy1,1,PcamAbs,Dataset.Projection.K,Dataset.Projection.WallsPc,1);
	[xyz2, dummy] = get3Dfrom2D(xy2,1,PcamAbs,Dataset.Projection.K,Dataset.Projection.WallsPc,1);

	%reproject to 2d
	% TODO only works for image 1?
	xy1Proj = homog22D(inv(R) * xyz1');
	xy2Proj = homog22D(inv(R) * xyz2');

	Dataset.HoughResult.HoughlinesProj(k).point1 = xy1Proj';
	Dataset.HoughResult.HoughlinesProj(k).point2 = xy2Proj';
end
Dataset.HoughResult.HoughlinesRotProj = Dataset.HoughResult.HoughlinesRot
for k = 1:length(Dataset.HoughResult.HoughlinesRot)
	k
	xy1 = Dataset.HoughResult.HoughlinesRot(k).point1';
	xy2 = Dataset.HoughResult.HoughlinesRot(k).point2';
	% project to 3d
	% TODO MAYBE IT IS IMAGE 4
	[xyz1, dummy] = get3Dfrom2D(xy1,1,PcamAbs,Dataset.Projection.K,Dataset.Projection.WallsPc,1);
	[xyz2, dummy] = get3Dfrom2D(xy2,1,PcamAbs,Dataset.Projection.K,Dataset.Projection.WallsPc,1);

	%reproject to 2d
	% TODO only works for image 1?
	xy1Proj = homog22D(inv(R) * xyz1');
	xy2Proj = homog22D(inv(R) * xyz2');

	Dataset.HoughResult.HoughlinesRotProj(k).point1 = xy1Proj';
	Dataset.HoughResult.HoughlinesRotProj(k).point2 = xy2Proj';
end


figure;
hold on;
plotHoughlinesAll(Dataset.ImReader.imHeight,Dataset.HoughResult.HoughlinesProj,Dataset.HoughResult.HoughlinesRotProj)
%plotHoughlines(Dataset.HoughResult.HoughlinesProj,'black');


%see project2Normal/project2squareHough
