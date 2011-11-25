% get corner point of wall
% backproject to image with imNr
% show backprojection in image
% make it rectangular by interpolating 

close all;
load WallsPc;
load PcamAbs; load Kcanon10GOOD;
load imgs;
Walls = WallsPc;

imNr = 1;
wallNr = 2;
R = getRotationMatrixFromWallNormal(Walls,wallNr)


nWalls = size(Walls,1);

% DRAWS WALL IN 2D
%
% XY = zeros(nWalls,2);
% XYsquare = zeros(nWalls,2);
% for pointNr=1:3:(length(Walls)-2)
% 	% get 3d corner coord of wall
% 	xy3D = [Walls(wallNr,pointNr),Walls(wallNr,pointNr+1), Walls(wallNr,pointNr+2)]'
% 	% save 2d at idx 1,2,3 etc.
% 	i = (pointNr+2)/3;
% 	XY(i,:) = get2Dfrom3D(xy3D, imNr, PcamAbs, Kcanon10GOOD);
% 	XYsquare(i,:) = homog22D(inv(R) * xy3D);
% end
% 
% %figPhoto = figure(); figure(figPhoto); imshow(imgs{imNr});
% %hold on;
% %plot(XY(:,1), XY(:,2), 'b-');
% 
% % stretch to plot nice  in image XYsquare = 50*(XYsquare+(4*ones(nWalls,2)))
% %figure(); imshow(imgs{imNr});
% 
% %plot(XYsquare(:,1), XYsquare(:,2), 'r-');



[w,h,dummy] = size(imgs{imNr})

clear imgOut;
% todo change to repmat
%for i=1:w



%todo calc from 3d transform
yMax=0.5878;
yMin=0.1837;
xMax=1.5380;
xMin=0.9470;
% 0.9470   -0.1837
% 1.5380   -0.1837
% 0.9470    0.5878
% 1.5380    0.5878
yFactor = h/(yMax-yMin)
xFactor = w/(xMax-xMin)

yFactor = yFactor/100
xFactor = xFactor/100

PlanePoint0 = [Walls(wallNr,1) Walls(wallNr,2) Walls(wallNr,3)];
PlanePoint1 = [Walls(wallNr,4) Walls(wallNr,5) Walls(wallNr,6)];
PlanePoint2 = [Walls(wallNr,7) Walls(wallNr,8) Walls(wallNr,9)];

% todo to repmat structure
endRange=800;
for i=708:endRange
	endRange-i
	%for j=1:h
	for j=245:700
		pixel = imgs{imNr}(i,j,:);
		xy=[i;j];
		%xy3D = get3Dfrom2D(xy, imNr, PcamAbs, Kcanon10GOOD, Walls, wallNr);
		projectionLine = getProjectionLine(xy, PcamAbs(:,4,:), Kcanon10GOOD, PcamAbs, imNr);

		xy3D = interSectPointFromLinePlane(projectionLine(1,:), projectionLine(2,:), PlanePoint0, PlanePoint1, PlanePoint2);

		xy3Drotated = inv(R) * xy3D';
		xy2Drotated = homog22D(inv(R) * xy3Drotated);
		x=-round(xFactor*xy2Drotated(1));
		y=round(yFactor*xy2Drotated(2));
		if x>0 && y>0
			imgOut( x,y,:)= pixel;
		end
	end
end


figure(); imshow(imgs{imNr});
figure(); imshow(imgOut)



% van 2d naar 3d
% xy = [0.9470, -0.1837];
% xyh = [xy(1), xy(2), 1];
% (xyh*R)
% get3Dfrom2D??
%0.9470   -0.1837
%moet worden:
% y3D =
% -1.7310
% 1.0000
% 7.2957


