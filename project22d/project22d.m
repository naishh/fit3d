%load Houghlines3d
clear Houghlines3d
clear Point

disp('v5')


% the letter T on wall 4 in coords

Point{1} = [2 3 5];
Point{2} = [2 3 0];
Point{3} = [2 2 0];
Point{4} = [2 2 1];
Point{5} = [2 0 1];
Point{6} = [2 0 2];
Point{7} = [2 2 2];
Point{8} = [2 2 5];

%connect the dots
for i=1:length(Point)-1
	Houghlines3d{1}(i).point1 = Point{i}
	Houghlines3d{1}(i).point2 = Point{i+1}
end


imNr = 1

% todo cleanup the loaded vars
load Walls

close all;

% todo do this in setup
PcamAbs 		= getTrajectory3DNorm(invertMotion(normalizePcam(PcamX)));
Cc 			= PcamAbs(1:3,4,imNr);
K			= Kcanon10GOOD;


wallNr = 4;
%wallNormal = getNormalFromWall(Walls, wallNr)
% z y x
% its the viewing and projection direction
wallNormal = [1 0 0.4]
figure;
hold on;

imNr = 1
%for imNr=1:length(Houghlines3d)
X = []
Y = []
	for i=1:length(Houghlines3d{imNr})
		i

		% R = PcamAbs(:,1:3,imNr);
		% T = PcamAbs(:,4,imNr);
		% xyPoint1 = inv(R) * K * (Houghlines3d{imNr}(i).point1' - T) 
		% xyPoint2 = inv(R) * K * (Houghlines3d{imNr}(i).point2' - T) 

		%for anglePercentage=0.2:0.2:1

			zAxis = [0 0 1];
			rotationVector = cross(zAxis, wallNormal)

			%angle = acos(dot(zAxis, wallNormal))*anglePercentage
			angle = acos(dot(zAxis, wallNormal))


			% could also be -R!!
			R = getRotationMatrix(rotationVector, angle)
			T = [0 0 0]

			xyPoint1 = inv(R) * Houghlines3d{imNr}(i).point1';
			xyPoint2 = inv(R) * Houghlines3d{imNr}(i).point2';
			% xyPoint1 = inv(R) * K * Houghlines3d{imNr}(i).point1';
			% xyPoint2 = inv(R) * K * Houghlines3d{imNr}(i).point2';

			% todo remove homognity
			xyPoint1 = homog22D(xyPoint1);
			xyPoint2 = homog22D(xyPoint2);

			X = [X,xyPoint1(1),xyPoint2(1)];
			Y = [Y,xyPoint1(2),xyPoint2(2)];

			plot(X,Y,'-')
			hold on;
			%pause;

		%end
	end
	disp('a')
%end

