load Houghlines3d
disp('v4')
pause;


% A = [2 0 1]
% B = [2 2 1]
% C = [2 0 2]
% 
% Houghlines3d{1}(1).point1 = A;
% Houghlines3d{1}(1).point2 = B;
% Houghlines3d{1}(2).point1 = A;
% Houghlines3d{1}(2).point2 = C;
% Houghlines3d{1}(3).point1 = B;
% Houghlines3d{1}(3).point2 = C;


imNr = 1

% todo cleanup the loaded vars
load Walls

close all;

% todo do this in setup
PcamAbs 		= getTrajectory3DNorm(invertMotion(normalizePcam(PcamX)));
Cc 			= PcamAbs(1:3,4,imNr);
K			= Kcanon10GOOD;


wallNr = 4;
wallNormal = getNormalFromWall(Walls, wallNr)
wallNormal = [1 0 0]
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

		for anglePercentage=0.2:0.2:1
			anglePercentage

			zAxis = [0 0 1];
			rotationVector = cross(zAxis, wallNormal)

			%angle = acos(dot(zAxis, wallNormal))
			angle = acos(dot(zAxis, wallNormal))*anglePercentage

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
			pause;

		end
	end
	disp('a')
%end

