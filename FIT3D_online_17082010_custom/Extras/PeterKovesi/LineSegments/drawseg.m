% DRAWSEG - Draws a series of line segments stored in an Nx4 array.
%
% Usage: drawseg(seglist, figNo, lw, col, marker);
%                            
%         seglist - an Nx4 array storing line segments in the form
%                    [x1 y1 x2 y2
%                     x1 y1 x2 y2
%                         . .     ] etc 
%         figNo   - optional figure number
%         lw      - optional line width
%         col     - optional 3-vector specifying the colour
%         marker  - optional character specifying a marker to be plotted at
%                   the end of each segment, eg '*'
%
%
% See also:  EDGELINK, LINESEG, MAXLINEDEV, MERGESEG
%

% Copyright (c) 2000-2005 Peter Kovesi
% School of Computer Science & Software Engineering
% The University of Western Australia
% http://www.csse.uwa.edu.au/
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.

% December 2000  Original version
% August   2006  Added option to specify marker plotted at end points

function drawseg(seglist, figNo, lw, col, marker);
    
    if nargin >= 2  
	figure(figNo);
    end
    
    if nargin < 3
	lw = 1;
	col = [0 0 1];
    elseif nargin < 4
	col = [0 0 1];
    end
    
    if nargin == 5  % A marker was specified
	plotMarkers = true;
    else
	plotMarkers = false;
    end
    
    clf

    Nseg = size(seglist,1);

    hold on
    for s = 1:Nseg
	line([seglist(s,1) seglist(s,3)], [seglist(s,2) seglist(s,4)],...
	     'LineWidth',lw, 'Color',col);
	if plotMarkers
	    hold on
	    plot([seglist(s,1) seglist(s,3)], [seglist(s,2) seglist(s,4)],marker); 
	end
    end
    
    axis('equal'), axis('ij')

