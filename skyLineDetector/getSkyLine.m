function [SkylineX, SkylineY, imRGBmarked, imBinary] = getSkyLine(imgNr, imRGB, imEdge, xStepSize, skylineThresh, bShowImages)
%Skyline
% walks columnwise down from the top and breaks when finding a building
% returns the y value (where the building starts) of every column
%
% default params:
% 	xStepSize = 1;
%	skylineThresh = 0.9;
	[h,w] = size(imEdge);
    imBinary = zeros(h,w);
    imRGBmarked = imRGB;
    
	SkylineX = 1:w;
	SkylineY = zeros(1,w);

    
	for x=1:xStepSize:w
		% start with 10 because of the bug
		for y=10:h
			% set current y coord as Skyline
			SkylineY(x) = y;
			% building detected, break
			if(imEdge(y,x) == 1)
				% fprintf('edge found at x,y %d, %d\n', x,y);
				% make skyline pixel red red
				%TODO evt in rgb
				imRGBmarked(y-2,x,:) = [255,0,0];
				imRGBmarked(y-1,x,:) = [255,0,0];
				imRGBmarked(y,x,:)   = [255,0,0];
				imRGBmarked(y+1,x,:) = [255,0,0];
				imRGBmarked(y+2,x,:) = [255,0,0];

				% TODO make line width param
                imBinary(y-2,x) = 1;
                imBinary(y-1,x) = 1;
                imBinary(y,x) = 1;
                imBinary(y+1,x) = 1;
                imBinary(y+2,x) = 1;
                %sprintf('breaked at x = %d, y = %d',y,x)
				break;
			end
		end
	end
	if bShowImages
		fh = figure;
		imshow(imRGBmarked);
		%figure;
		%imshow(imBinary,[]);
    end
	%saveas(fh, ['outputSkylineIm',int2str(imgNr),'.jpg'],'jpg');
