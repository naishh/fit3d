% CIRCSINE - generates circular sine wave grating
%
% Usage:    im = circsine(sze, wavelength, p, trim)
%
% Arguments:
%           sze        - The size of the square image to be produced.
%           wavelength - The wavelength in pixels of the sine wave.
%           p          - optional parameter specifying the norm to
%                        use in calculating the radius from the
%                        centre. This defaults to 2, resulting in a
%                        circular pattern.  Large values gives
%                        a square pattern
%           trim       - Optional flag indicating whether you want the
%                        circular pattern trimmed from the corners leaving
%                        only complete cicles. Defaults to 0.

% Copyright (c) 2003-2006 Peter Kovesi
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

% May 2003 - Original version
% Nov 2006 - Modified so that the circular pattern is removed from the
%            'corners of the image.

function im = circsine(sze,wavelength, p, trim)

    if nargin < 4
	trim = 0;
    end
    if nargin < 3
	p = 2;
    end
    if mod(p,2)
	error('p should be an even number');
    end
    
    % Place origin at centre for odd sized image, and below and the the
    % right of centre for an even sized image
    if mod(sze,2) == 0   % even sized image
	l = -sze/2;
	u = sze/2-1;
    else
	l = -(sze-1)/2;
	u = (sze-1)/2;
    end
    
    [x,y] = meshgrid(l:u);
    r = (x.^p + y.^p).^(1/p);

    im = cos(r * 2*pi/wavelength);  % Actually use the cos function because 
				    % its slope is zero at the origin.

    if trim     % Remove circular pattern from the 'corners'
	cycles = fix(sze/2/wavelength); % No of complete cycles within sze/2
	im = im.* (r < cycles*wavelength) + (r>= cycles*wavelength);
    end
    
     