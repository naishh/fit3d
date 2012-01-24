% FASTRADIAL - Loy and Zelinski's fast radial feature detector
%
% An implementation of Loy and Zelinski's fast radial feature detector
%
% Usage: S = fastradial(im, radii, alpha)
%
% Arguments:
%            im    - image to be analysed
%            radii - array of integer radius values to be processed
%                    suggested radii might be [1 3 5]
%            alpha - radial strictness parameter.
%                    1 - slack, accepts features with bilateral symmetry.
%                    2 - a reasonable compromise.
%                    3 - strict, only accepts radial symmetry.
%                        ... and you can go higher
%
% Returns    S      - Symmetry map.  Bright points with high symmetry are
%                     marked with large positive values. Dark points of
%                     high symmetry marked with large -ve values.
%
% To localize points use NONMAXSUPPTS on S, -S or abs(S) depending on
% what you are seeking to find.

% Reference:
% Loy, G.  Zelinsky, A.  Fast radial symmetry for detecting points of
% interest.  IEEE PAMI, Vol. 25, No. 8, August 2003. pp 959-973.

% Copyright (c) 2004-2005 Peter Kovesi
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

% November 2004  - original version
% July     2005  - Bug corrected: magitude and orientation matrices were
%                  not zeroed for each radius value used (Thanks to Ben
%                  Jackson) 

function S = fastradial(im, radii, alpha)
    
    if any(radii ~= round(radii)) | any(radii < 1)
        error('radii must be integers and > 1')
    end
    
    [rows,cols]=size(im);
    
    % Use the Sobel masks to get gradients in x and y
    gx = [-1 0 1
          -2 0 2
          -1 0 1];
    gy = gx';
    
    imgx = filter2(gx,im);
    imgy = filter2(gy,im);
    mag = sqrt(imgx.^2 + imgy.^2)+eps; % (+eps to avoid division by 0)
    
    % Normalise gradient values so that [imgx imgy] form unit 
    % direction vectors.
    imgx = imgx./mag;   
    imgy = imgy./mag;
    
    S = zeros(rows,cols);  % Symmetry matrix
    
    [x,y] = meshgrid(1:cols, 1:rows);
    
    for n = radii
	M = zeros(rows,cols);  % Magnitude projection image
	O = zeros(rows,cols);  % Orientation projection image

        % Coordinates of 'positively' and 'negatively' affected pixels
        posx = x + round(n*imgx);
        posy = y + round(n*imgy);
        
        negx = x - round(n*imgx);
        negy = y - round(n*imgy);
        
        % Clamp coordinate values to range [1 rows 1 cols]
        posx( find(posx<1) )    = 1;
        posx( find(posx>cols) ) = cols;
        posy( find(posy<1) )    = 1;
        posy( find(posy>rows) ) = rows;
        
        negx( find(negx<1) )    = 1;
        negx( find(negx>cols) ) = cols;
        negy( find(negy<1) )    = 1;
        negy( find(negy>rows) ) = rows;
        

        % Form the orientation and magnitude projection matrices
        for r = 1:rows
            for c = 1:cols
                O(posy(r,c),posx(r,c)) = O(posy(r,c),posx(r,c)) + 1;
                O(negy(r,c),negx(r,c)) = O(negy(r,c),negx(r,c)) - 1;
                
                M(posy(r,c),posx(r,c)) = M(posy(r,c),posx(r,c)) + mag(r,c);
                M(negy(r,c),negx(r,c)) = M(negy(r,c),negx(r,c)) - mag(r,c);
            end
        end
        
        % Clamp Orientation projection matrix values to a maximum of 
        % +/-kappa,  but first set the normalization parameter kappa to the
        % values suggested by Loy and Zelinski
        if n == 1, kappa = 8; else, kappa = 9.9; end
        
        O(find(O >  kappa)) =  kappa;  
        O(find(O < -kappa)) = -kappa;  
        
        % Unsmoothed symmetry measure at this radius value
        F = M./kappa .* (abs(O)/kappa).^alpha;
        
        % Generate a Gaussian of size proportional to n to smooth and spread 
        % the symmetry measure.  The Gaussian is also scaled in magnitude
        % by n so that large scales do not lose their relative weighting.
        A = fspecial('gaussian',[n n], 0.25*n) * n;  
        
        S = S + filter2(A,F);
        
    end  % for each radius
    
    S = S/length(radii);  % Average