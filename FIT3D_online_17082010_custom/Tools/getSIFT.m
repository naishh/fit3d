% getSIFT - SIFT extractor 
%
% Computes SIFT features for all the images in a given directory
%
%
% Input  - dir       -> (1x1) String Directory that contains the images
%        - key       -> (1x1) Unique id for extracting sift features
%                       simultaneously
%        - maxFrames -> (1x1) Maximum number of frames to process
%        - step      -> (1x1) Skip every step image
%        - METHOD    -> (String) Method to recover features (available
%                       options: [LOWE, VL_FEAT])
%
% Output - F         -> (nx137) [1xid, 1xframe, 128xdescriptors,
%                       4xlocators, 3xRGB]
%        - Files     -> (1x1) Struct with the information of the files
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function [F,Files] = getSIFT(directory,maxFrames,step, METHOD)

    % Obtain files in the directory
    files = dir(directory);
    files = files(3:end);
    
    % Reserve some space for the features. This saves time when a lot of
    % images are used.
    F = ones(500000,137);
    
    lastIndex = 0;
    
    i = 3;
    
   
    % Process all the images in pairs
    for j=1:step:min(size(files,1),maxFrames)
        
        % Read filename
        img1File = files(j).name;
        img1File = strcat(directory,img1File);

        img1FileBW = strcat(files(j).name,'_BW.jpg');
        img1FileBW = strcat(directory,img1FileBW);
        
        % Check if the images are RGB or grayscale, load it and adjust it
        tmpim1 = im2double(imread(img1File));

        if(size(tmpim1,3)~=1)
            IMAGETYPE = 'RGB';
        else
            IMAGETYPE = 'GRAY'; 
        end;
        
        % If the image is in color, create a BW one
        if(strcmp(IMAGETYPE,'RGB')==1)
            tmpim1BW = rgb2gray(tmpim1);
            %tmpim1 = imadjust(tmpim1,stretchlim(tmpim1),[0 1], 0.6);
            im1File = [img1FileBW];
            
            %% NOTE THAT THE FOLLOWING LINE IS REQUIRED IF YOU USE LOWEs
            %% SIFT
            
            %imwrite(tmpim1BW,img1FileBW);
            clear tmpim1BW;
        else
            im1File = img1File;
        end;
               
        fprintf('File: %s \n',img1File);
        
        % Extract features
        % LOWE
        if(strcmp(METHOD,'LOWE'))
            [image, descriptors, loc] = sift(im1File);
        % VL_FEAT    
        elseif(strcmp(METHOD,'VL_FEAT'))
            [f1,d1] = vl_sift(single(rgb2gray(tmpim1)));
            descriptors = double(d1)';
            loc = double(f1)';
            loc(:,1) = f1(2,:)';
            loc(:,2) = f1(1,:)';
        end;
        
        
        
                
        % Number of features
        nSift = size(descriptors,1);
        
        fprintf('%d features found \n',nSift);
        
        % Get intensities or colors
        if(strcmp(IMAGETYPE,'GRAY')==1)
            R = tmpim1(sub2ind(size(tmpim1), round(loc(:,1)), round(loc(:,2))));
            G = R;
            B = R;
        elseif(strcmp(IMAGETYPE,'RGB')==1)
            R = tmpim1(sub2ind(size(tmpim1), round(loc(:,1)), round(loc(:,2)), ones(nSift, 1)));
            G = tmpim1(sub2ind(size(tmpim1), round(loc(:,1)), round(loc(:,2)), 2*ones(nSift, 1)));
            B = tmpim1(sub2ind(size(tmpim1), round(loc(:,1)), round(loc(:,2)), 3*ones(nSift, 1)));
        end

        
        % Add them to the table  
        newEntry = [[lastIndex+1:1:lastIndex+size([ones(size(descriptors,1),1).*(i-2),descriptors,loc],1)]',ones(size(descriptors,1),1).*(i-2),descriptors,loc,R,G,B];
        F(lastIndex+1:lastIndex+nSift,:) = newEntry;
        lastIndex = lastIndex+nSift;
        
        % Clean memory
        clear tmpim1 image descriptors loc nSift R G B newentry;
       
        i = i+1;
        
    end;
    
    % Clean up
    F = F(2:lastIndex,:);
    
    
    Files = struct;
    Files.files = files;
    Files.dir = directory;
