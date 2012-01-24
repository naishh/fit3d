% matchSIFT - Determines matches between 2 sets of features 
%
% Determines the indexes of the 2 sets of SIFT descriptors that match
% according to a distance ratio threshold. The method is according to Lowes
% code available online.
%
%
% Input  - descriptors1 -> nx128 SIFT descriptors of image A
%        - descriptors2 -> mx128 SIFT descriptors of image B
%        - distRatio    -> 1x1 distance ratio to use for matching
%
% Output - i1           -> 1xnumOfMatches index of matching points in image A
%          i2           -> 1xnumOfMatches index of matching points in image B
%          numOfMatches -> 1x1 number of matches
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [i1,i2, numOfMatches] = matchSIFT(descriptors1, descriptors2, distRatio)

    % Compute matches using distance between features
    % Precompute matrix transpose
    descriptors2t = descriptors2';    
    
    % For all features in the set 1
    for i = 1 : size(descriptors1,1)
       % Compute vector of dot products
       dotprods = descriptors1(i,:) * descriptors2t;        
       % Take inverse cosine and sort results
       [vals,indx] = sort(acos(dotprods)); 

       % Check if nearest neighbor has angle less than distRatio times 2nd.
       if (vals(1) < distRatio * vals(2))
          matches(i) = indx(1);
       else
          matches(i) = 0;
       end
    end


    % Total number of matches
    numOfMatches = sum(matches>0);
    
    % Extract the matching indexes
    i1 = zeros(numOfMatches,1);
    i2 = zeros(numOfMatches,1);
    counter = 1;
    for i = 1:size(matches,2)
        if(matches(i)~=0)
            i1(counter) = i;
            i2(counter) = matches(i);
            counter = counter+1;
        end;
    end;
    
