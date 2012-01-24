% showMatches - Show sift matches  
%
% Displays the matching features of two frames given the matching matrix
% Fplus, the indices of the two images and the directory that contains the
% images.
%
%
% Input  - Fplus     -> (nx9) Features in Fplus format
%        - i1        -> (1x1) Index of image 1
%        - i2        -> (1x1) Index of image 2
%        - files     -> (1x1) struct containing the file names
%        - directory -> (1x1) directory where the files are
%
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function showMatches(Fplus,i1,i2, files, directory)

    img1 = imread(strcat(directory,files(i1).name));
    img2 = imread(strcat(directory,files(i2).name));
    
    F = Fplus(Fplus(Fplus(:,3)==i2,2)==i1,:);
    
    hold on   
    imshow([img1;img2]);hold on;plot(F(:,5),F(:,4),'bo');plot(F(:,7),F(:,6)+size(img1,1),'bo');hold off;
    
