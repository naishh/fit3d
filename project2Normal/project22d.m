%close all;
load Houghlines3d


load Walls

% todo do this in setup
PcamAbs 		= getTrajectory3DNorm(invertMotion(normalizePcam(PcamX)));
Cc 				= PcamAbs(1:3,4,imNr);
K				= Kcanon10GOOD;

imNr = 1
wallNr = 7;

% % the y axis is inverted because matlab plots upside down
% % this is to flip the y axis 
yHeight = 200;

wallNormal = getNormalFromWall(Walls, wallNr)
% its the viewing and projection direction
%wallNormal = [1 0.1 0.1]
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

			% normalise wall normal
			wallNormal = wallNormal/norm(wallNormal)
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
			%Y = [Y,yHeight-xyPoint1(2),yHeight-xyPoint2(2)];
			Y = [Y,xyPoint1(2),xyPoint2(2)];

			% plot individual line segments
			for xi=1:2:length(X)
				plot(X(xi:xi+1), Y(xi:xi+1), '-')
			end
			hold on;
			%pause;

		%end
	end
%end

