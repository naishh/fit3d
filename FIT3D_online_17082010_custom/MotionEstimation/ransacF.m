% ransacF - RANSAC algorithm for the estimation of the fundamental matrix
%
%
% Computes the fundamental matrix given two sets of corresponding points. Based on
% the 8-point algorithm described by Zisserman in p282.
%
%
% Input  - X1         -> (3xn) set of homogeneous points in image A
%        - X2         -> (3xn) set of homogeneous points in image B
%        - N          -> (1x1) Number of iterations
%        - threshold  -> (1x1) Threshold to use
%
% Output - F          -> (3x3) fundamental matrix F
%          bestModel  -> (nx1) indices of inlying points
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [F, bestmodel] = ransacF(X1,X2,N,threshold)


    % Parameters
    t = threshold;
    %t = 0.001;
    %N = 1000;
    
    % Best scores
    bestscore = 0;
    bestmodel = [];
    
    % Normalize points
    [X1t,T1] = normalize2Dpoints(X1);
    [X2t,T2] = normalize2Dpoints(X2);
    

    % Set used to converge faster (not used now)
    SETX1 = X1;
    SETX2 = X2;
    
    
    % RANSAC
    counter = 1;
    while(counter<N)
        i=counter;
        
        % Select 8 random points
        %rindex = ceil(rand(8,1)*size(X1,2));
        rindex = getNRandom(8,size(SETX1,2));
     
        
        % Compute the fundamental matrix
        Ft = eightpoint(SETX1(:,rindex),SETX2(:,rindex));
                
        % If it can be computed...
        if(sum(sum(isnan(Ft))) == 0)
            
            
             %d=diag( X2t'*(K'*Ft*K)*X1t)'; 
%              d=diag( X2t'*(Ft)*X1t)'; 
% 
%              inliersL = find(abs(d) < t);
%              if(length(inliersL)>bestscore)
%                  bestscore = length(inliersL);
%                  bestmodel = inliersL;
% %                 %SETX1 = X1(:,bestmodel);
% %                 %SETX2 = X2(:,bestmodel);
%              end;





            X2tFX1 = zeros(1,size(X1,2));
            for n = 1:size(X1,2)
                X2tFX1(n) = X2(:,n)'*Ft*X1(:,n);
            end

            FX1 = Ft*X1;
            FtX2 = Ft'*X2;     

            % Evaluate distances
            d =  X2tFX1.^2 ./ (FX1(1,:).^2 + FX1(2,:).^2 + FtX2(1,:).^2 + FtX2(2,:).^2);
            %d=diag( X2t'*(Ft)*X1t)'; 
            
            % Indices of inlying points
            inliersL = find(abs(d) < t);     
                       
            
            % Check this model (size of the inliers set)
            if(length(inliersL)>bestscore && length(inliersL)>7)
                bestscore = length(inliersL);
                bestmodel = inliersL;
                %SETX1 = X1(:,bestmodel);
                %SETX2 = X2(:,bestmodel);
            end;
            

        end;
        
    counter = counter+1;    
    end;
    
    %fprintf('N. Inliers:  %d\n', size(X1(:,bestmodel),2));
    %fprintf('N. Outliers: %d\n', size(X1,2)-size(X1(:,bestmodel),2));

        
    % Reestimate F based on the inliers of the best model only 
    if(length(X1(:,bestmodel))>=8)
        F = eightpoint(X1(:,bestmodel),X2(:,bestmodel));
    else
        F = zeros(3,3);
    end;
    

