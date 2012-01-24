% ransacFfive - RANSAC algorithm for the estimation of the fundamental
% matrix using the five point algorithm
%
%
% This is a ransac implementation using the calibrated five point solver of
% Henrik Stewenius. Due to license constraints we are unable to distribute
% his code and refer the user to http://vis.uky.edu/~stewe. Please read the
% INSTALLATION.txt before attempting to use this.
%
%
% Input  - A          -> (3xn) set of homogeneous points in image A
%        - B          -> (3xn) set of homogeneous points in image B
%        - N          -> (1x1) Number of iterations
%        - threshold  -> (1x1) Threshold to use
%        - K          -> (3x3) Calibration matrix
%
% Output - F          -> (3x3xn) Fundamental matrices F
%        - bestmodel  -> (nx1) Set of inliers
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [F, bestmodel] = ransacFfive(X1,X2,N,threshold,K)

    % Parameters
    t = threshold;
    %t = 0.001;
    %N = 1000;
    
    % Best scores
    bestscore = 0;
    bestmodel = [];
    bestE = zeros(3,3);
    
    % List of points
    inliers = [];   
    counter = 1;
    
    % First normalize the points
    [X1t,T1] = normalize2Dpoints(X1);
    [X2t,T2] = normalize2Dpoints(X2);

    
    % Normalization for 5-point
    X1n = X1;
    X2n = X2;
    for(i=1:size(X1n,2))
        X1n(:,i) = inv(K)*X1(:,i);
        X2n(:,i) = inv(K)*X2(:,i);
    end;
    
    SETX1 = X1;
    SETX2 = X2;
    
    counter = 1;
    while(counter<N)
        i=counter;
        
        % Select 8 random points
        %rindex = ceil(rand(8,1)*size(X1,2));
        rindex = getNRandom(5,size(SETX1,2));
        
        % Compute the fundamental matrix
        %Ft = eightpoint(X1(:,rindex),X2(:,rindex));
        %E5 = calibrated_fivepoint(X1(:,rindex),X2(:,rindex)); 
        E5 = calibrated_fivepoint(X1n(:,rindex),X2n(:,rindex)); 
        
        E5e = zeros(3,3,size(E5,2));
        for i=1:size(E5,2)
            E5e(:,:,i) = reshape(E5(:,i),3,3)';
        end

        % Check inliers and pick best one
        for(i=1:size(E5e,3))

            Et = E5e(:,:,i);
            Ft = inv(K)'*Et*inv(K);

            % If it can be computed...
            if(sum(sum(isnan(Ft))) == 0)

                
                X2tFX1 = zeros(1,size(X1t,2));
                for n = 1:size(X1t,2)
                    X2tFX1(n) = X2n(:,n)'*Et*X1n(:,n);
                end

                FX1 = Ft*X1n;
                FtX2 = Ft'*X2n;     

                % Evaluate distances
                d =  X2tFX1.^2 ./ (FX1(1,:).^2 + FX1(2,:).^2 + FtX2(1,:).^2 + FtX2(2,:).^2);

                % Indices of inlying points
                inliersL = find(abs(d) < t);     

                % Check this model (size of the inliers set)
                if(length(inliersL)>bestscore && length(inliersL)>4)
                    bestscore = length(inliersL);
                    bestmodel = inliersL;
                    bestE = Et;
                    %SETX1 = X1(:,bestmodel);
                    %SETX2 = X2(:,bestmodel);
                end;

                
                %d=diag( X2t'*Et*X1t); 
                %inliersL = find(abs(d) < t);
                %if(length(inliersL)>bestscore)
                %    bestscore = length(inliersL);
                %    bestmodel = inliersL;
                %    bestE = Et;
                %end;
            

            end;

        end;
        

        

    counter = counter+1;    
    end;
    
    fprintf('N. Inliers:  %d\n', size(X1(:,bestmodel),2));
    fprintf('N. Outliers: %d\n', size(X1,2)-size(X1(:,bestmodel),2));

    

        
%     % Reestimate F based on the inliers of the best model only 
     if(length(X1(:,bestmodel))>=5)
         E5 = calibrated_fivepoint(X2n(:,bestmodel),X1n(:,bestmodel)); 
       
         E5e = zeros(3,3,size(E5,2));
         for i=1:size(E5,2)
             E5e(:,:,i) = reshape(E5(:,i),3,3)';
         end
         
         for(i=1:size(E5e,3))

            Et = E5e(:,:,i);
            Ft = inv(K)'*Et*inv(K);

            % If it can be computed...
            if(sum(sum(isnan(Ft))) == 0)


                X2tFX1 = zeros(1,size(X1t,2));
                for n = 1:size(X1t,2)
                    X2tFX1(n) = X2n(:,n)'*Et*X1n(:,n);
                end

                FX1 = Ft*X1n;
                FtX2 = Ft'*X2n;     

                % Evaluate distances
                d =  X2tFX1.^2 ./ (FX1(1,:).^2 + FX1(2,:).^2 + FtX2(1,:).^2 + FtX2(2,:).^2);

                % Indices of inlying points
                inliersL = find(abs(d) < t);     

                % Check this model (size of the inliers set)
                if(length(inliersL)>bestscore && length(inliersL)>4)
                    bestscore = length(inliersL);
                    bestmodel = inliersL;
                    bestE = Et;
                    %SETX1 = X1(:,bestmodel);
                    %SETX2 = X2(:,bestmodel);
                end;

            end;

    end;
         
     end;

     
     % 
%     
%     E5e = zeros(3,3,size(E5,2));
%     for i=1:size(E5,2)
%         E5e(:,:,i) = reshape(E5(:,i),3,3);
%     end
    
    
    % Check the one with most inliers
    % Check inliers and pick best one
%     bestscore = 0;
%     bestmodel = [];
%     bestE = zeros(3,3);
% 
%     
%     bT = 10e10;
%     dT = 10e10;
%     cT = 10e10;
%     
%     for(i=1:size(E5e,3))
% 
%         Et = E5e(:,:,i);
%         Ft = inv(K)'*Et*inv(K);
% 
%         % If it can be computed...
%         if(sum(sum(isnan(Ft))) == 0)
% 
%             b=det(Et);             
%             prod= Et*Et'*Et;
%             c=norm(2 * prod - trace(prod));  
% 
%             dd=diag( X2n'*Et*X1n); 
%             d=norm(dd);
% 
%             
%             d=diag( X2t'*Et*X1t)'; 
%             inliersL = find(abs(d) < t);
%             size(inliersL)
%             %if(norm(d)<dT)
%             %if(sum(d)<dT)
%             %if(length(inliersL)>bestscore)
%             %if(length(inliersL)>bestscore && sum(d)<dT)
%             if(sum(mean([b,c,d])<sum(mean([bT,cT,dT]))))
%                 bestscore = length(inliersL);
%                 bestmodel = inliersL;
%                 bestE = Et;
%                 bT = b;
%                 cT = c;
%                 dT = d;
%                 %dT = sum(d);
%             end;
% 
%         end;
% 
%     end;


    F = inv(K)'*bestE*inv(K);
