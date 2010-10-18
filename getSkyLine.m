function Skyline = getSkyLine(imRGB, imBW, xStepSize, skylineThresh)
%Skyline
% walks columnwise down from the top and breaks when finding a building
% returns the y value (where the building starts) of every column
%
% default params:
% 	xStepSize = 1;
%	skylineThresh = 0.9;
	[h,w] = size(imBW);
	Skyline = zeros(1,w);

	for x=1:xStepSize:w
		% start with 10 because of the bug
		for y=10:h
			% set current y coord as Skyline
			Skyline(y) = x;
			% building detected, break
			if(imBW(y,x) == 1)
				% make skyline pixel red red
				imRGB(y-1,x,:) = [255,0,0];
				imRGB(y,x,:) = [255,0,0];
				imRGB(y+1,x,:) = [255,0,0];
				%sprintf('breaked at x = %d, y = %d',y,x)
				break;
			end
		end
	end

	figure;imshow(imRGB);
	%why doesn't this work...
	%line([1:xStepSize:w],Skyline([1:xStepSize:w]),'LineWidth',2);
