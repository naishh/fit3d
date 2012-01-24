% ransac2D - RANSAC algorithm for the estimation of a 2D homography
%
%
% Computes the homography given two sets of corresponding points. Based on
% the DLT algorithm described by Zisserman in p109.
%
%
% Input  - X1 -> (3xn) set of homogeneous points in image A
%        - X2 -> (3xn) set of homogeneous points in image B
%
% Output - H  -> (3x3) homography matrix
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [H] = ransac2D(X1,X2)

    % Parameters
    sigma = 0.99;
    t = sqrt(5.99)*sigma;
    N = 1500;
    
    % List of points
    inliers = [];
    counter = 1;
    
    % For N iterations
    for i =1:N
        
        % Select 4 random (non repeated) points
        rindex = getNRandom(4,size(X1,2));
        
        % Compute the homography using dlt
        Ht = dlt2D(X1(:,rindex),X2(:,rindex));
            
        % If it can be computed
        if(sum(sum(isnan(Ht))) == 0)
                    
            % Calculate the error and classify points as inliers/outliers
            for p=1:size(X1,2)
                
                % Error
                e = symmetricTransferError(X1(:,p),X2(:,p),Ht);
                % If below threshold, set as inlier
                if (e < t)
                    if(sum(inliers == p)==0)
                        inliers(counter) = p;
                        counter = counter+1;
                    end;
                end;
            end;
        end;
        
    end;
    
    fprintf('INLIERS %d\n',size(X1(:,inliers),2));
    fprintf('OUTLIERS %d\n',size(X1,2)-size(X1(:,inliers),2));
        
    % Reestimate H based on the inliers only using LM algorithm (golden
    % standard)
    H = goldStd2D(X1(:,inliers),X2(:,inliers));
    
    
    
