function [SkylineX, SkylineY, imMarked, imBinary] = getSkyLine(imNr, imRGB, imEdge, xStepSize, skylineThresh)
%Skyline
% walks columnwise down from the top and breaks when finding a building
% returns the y value (where the building starts) of every column
%
% default params:
% 	xStepSize = 1;
%	skylineThresh = 0.9;
	[h,w] = size(imEdge);
    imBinary = zeros(h,w);
    imMarked = imRGB;
    
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
				imMarked(y-3,x,:) = [255, 0, 0];
				imMarked(y-2,x,:) = [255, 0, 0];
				imMarked(y-1,x,:) = [255, 0, 0];
				imMarked(y,x,:)   = [255, 0, 0];
				imMarked(y+1,x,:) = [255, 0, 0];
				imMarked(y+2,x,:) = [255, 0, 0];
				imMarked(y+3,x,:) = [255, 0, 0];

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
	%saveas(fh, ['outputSkylineIm',int2str(imNr),'.jpg'],'jpg');
