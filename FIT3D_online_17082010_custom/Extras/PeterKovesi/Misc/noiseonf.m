% NOISEONF - Creates 1/f spectrum noise images.
%
% Function to create noise images having 1/f amplitude spectum properties
%
% Usage: im = noiseonf(size, factor)
%
%        size   - size of image to produce
%        factor - controls spectrum = 1/(f^factor)
%
%        factor = 0   - raw Gaussian noise image
%               = 1   - gives the 1/f `standard' drop-off for `natural' images
%               = 1.5 - seems to give the most intersting `cloud patterns'
%               = 2 or greater - produces `blobby' images

% Copyright (c) 1996-2005 Peter Kovesi
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

%  December 1996
%  August   2005  Octave compatible

function im = noiseonf(size, factor)

v=version; Octave=v(1)<'5';  % Crude Octave test
rows = size;
cols = size;

% Generate an image of random Gaussian noise, mean 0, std dev 1.    
if Octave
    im = randn(size); 
else    
    im = random('norm',0,1,size,size);  
end

imfft = fft2(im);                   % Take fft of image.
imfft = fftshift(imfft);            % Shift 0 frequency to the middle.
mag = abs(imfft);                   % Get magnitude
phase = imfft./mag;                 % and phase

% Create two matrices, x and y. All elements of x have a value equal to its 
% x coordinate relative to the centre, elements of y have values equal to 
% their y coordinate relative to the centre.  From these two matrices produce
% a radius matrix that gives distances from the middle

x = ones(rows,1) * (-cols/2 : (cols/2 - 1)); 
y = (-rows/2 : (rows/2 - 1))' * ones(1,cols);
radius = sqrt(x.^2 + y.^2);         % Matrix values contain radius from centre.
radius(rows/2+1,cols/2+1) = 1;      % .. avoid division by zero.

filter = 1./(radius.^factor);       % Construct the filter.

% Reconstruct fft of noise image, but now with the specified amplitude spectrum
newfft =  filter .* phase; 
im = real(ifft2(fftshift(newfft))); % Invert to obtain final noise image

caption = sprintf('noise with 1/(f^%2.1f) amplitude spectrum',factor);
imagesc(im), axis('equal'), axis('off'), title(caption);