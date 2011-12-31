%TODO Cleanup this file  and make comments
close all;
%load('../doorWindow/mats/Houghlines_floriande5435.mat'); load('../doorWindow/mats/HoughlinesRot_floriande5435.mat');
load('../doorWindow/mats/Houghlines_floriande5447.mat'); load('../doorWindow/mats/HoughlinesRot_floriande5447.mat');
%Houghlines = mergeHoughlines(Houghlines,HoughlinesRot);

load Walls
load PcamAbs
load Kcanon10GOOD

tic;


% % the y axis is inverted because matlab plots upside down
% % this is to flip the y axis 
% TODO Check wallnr
wallNr = 7;
imNr = 3;
wallNormal = getNormalFromWall(Walls, wallNr)
wallNormal = wallNormal/norm(wallNormal) % normalise wall normal
zAxis = [0 0 1];
rotationVector = cross(zAxis, wallNormal)
angle = acos(dot(zAxis, wallNormal)) % could also be -R!!
R = getRotationMatrix(rotationVector, angle)
T = [0 0 0]


% TODO GET EDGE IMAGE set houghlines in loop below
% TODO optimize to get fast matrix calculation

X = [];
Y = [];
for k = 1:length(Houghlines)
	xy1 = Houghlines(k).point1';
	xy2 = Houghlines(k).point2';
	% project to 3d
	% TODO MAYBE IT IS IMAGE 4
	[xyz1, dummy] = get3Dfrom2D(xy1,imNr,PcamAbs,Kcanon10GOOD,Walls,9);
	[xyz2, dummy] = get3Dfrom2D(xy2,imNr,PcamAbs,Kcanon10GOOD,Walls,9);

	%reproject to 2d
	% TODO only works for image 1?
	xy1Proj = homog22D(inv(R) * xyz1');
	xy2Proj = homog22D(inv(R) * xyz2');

	Houghlines(k).point1 = xy1Proj';
	Houghlines(k).point2 = xy2Proj';
	
	X = [X,xy1Proj(1),xy2Proj(1)];
	Y = [Y,xy1Proj(2),xy2Proj(2)];
end

figure;
hold on;
% plot individual line segments
for i=1:2:length(X)
	plot(X(i:i+1), -Y(i:i+1), 'g-','lineWidth',2);
end




% HOUGHLINES ROT
X = [];
Y = [];
for k = 1:length(HoughlinesRot)
	xy1 = HoughlinesRot(k).point1';
	xy2 = HoughlinesRot(k).point2';
	% project to 3d
	% TODO MAYBE IT IS IMAGE 4
	[xyz1, dummy] = get3Dfrom2D(xy1,imNr,PcamAbs,Kcanon10GOOD,Walls,9);
	[xyz2, dummy] = get3Dfrom2D(xy2,imNr,PcamAbs,Kcanon10GOOD,Walls,9);

	%reproject to 2d
	% TODO only works for image 1?
	xy1Proj = homog22D(inv(R) * xyz1');
	xy2Proj = homog22D(inv(R) * xyz2');
	
	HoughlinesRot(k).point1 = xy1Proj';
	HoughlinesRot(k).point2 = xy2Proj';

	X = [X,xy1Proj(1),xy2Proj(1)];
	Y = [Y,xy1Proj(2),xy2Proj(2)];
end

% plot individual line segments
for i=1:2:length(X)
	plot(X(i:i+1), -Y(i:i+1), 'r-','lineWidth',2);
end


toc;

save Houghlines
save HoughlinesRot
