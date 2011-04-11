load Houghlines3d
% todo cleanup the loaded vars
load outputVars_scriptComputeCameraMotion
load Walls

close all;

% todo do this in setup
PcamAbs 	= getTrajectory3DNorm(invertMotion(normalizePcam(PcamX)));
Cc 			= PcamAbs(1:3,4,imNr);
K			= Kcanon10GOOD;


wallNr = 7;
wallNormal = getNormalFromWall(Walls, wallNr)
pause;
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

		zAxis = [0 0 1];
		rotationVector = cross(zAxis, wallNormal)
		angle = acos(dot(zAxis, wallNormal))

		% could also be -R!!
		R = getRotationMatrix(rotationVector, angle)
		T = [0 0 0]

		xyPoint1 = inv(R) * Houghlines3d{imNr}(i).point1';
		xyPoint2 = inv(R) * Houghlines3d{imNr}(i).point2';
		% xyPoint1 = inv(R) * K * Houghlines3d{imNr}(i).point1';
		% xyPoint2 = inv(R) * K * Houghlines3d{imNr}(i).point2';

		% todo remove homognity
		xyPoint1 = homog22D(xyPoint1)
		xyPoint2 = homog22D(xyPoint2)

		X
		Y
		
		X = [X,xyPoint1(1),xyPoint2(1)]
		Y = [Y,xyPoint1(2),xyPoint2(2)]

		plot(X,Y,'-')
		hold on;
	end
	disp('a')
%end

