% computeCameraMotion - Compute the motion of a camera
%
% Given a set of features obtained from images, the motion of the camera is computed.
%
%
% Input  - MATCHINGMETHOD   -> (String) Method for feature Matching (MATLAB,VEDALDI,VL_FEAT)
%        - F                -> (nx137) n features x [id,frame,descriptor,locator,R,G,B]
%        - distRatio        -> (1x1) distance ratio between frames
%        - window           -> (1x1) for matching multiple frames (w)
%        - ransacIterations -> (1x1) number of ransac iterations
%        - K                -> (3x3) camera calibration matrix
%        - maxFrames        -> (1x1) max number of frames to process (k)
%        - runBA            -> (1x1) true or false to use BA
%        - motionAlgorithm  -> (1x1) '8pts' or '5pts'       
%        - ransacThreshold  -> (1x1) threshold for inlier detection
%	 - BAiterations	    -> (1x1) Iterations for local refinement
%
% Output - Fplus            -> (nx9) [frame1,frame2,X1,Y1,X2,Y2, R,G,B]
%                              (only inliers)
%        - PcamPlus         -> (3x4xkxw) All camera matrices after motion
%                              estimation
%        - PcamX            -> (3x4xk) Frame-to-frame motions. Equivalent
%                              to PcamPlus(:,:,:,1)
%        - FplusExtra       -> (nx9) [frame1,frame2,X1,Y1,X2,Y2, R,G,B]
%                              (brute force matches)
%        - KBA              -> (3x3xn) Optimized camera calibration
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function [Fplus, PcamPlus, PcamX, FplusExtra,KBA] = computeCameraMotion(MATCHINGMETHOD,F, distRatio, window, ransacIterations, K, maxFrames, runBA, motionAlgorithm, ransacThreshold, BAiterations)

    % New matrix to store the matches
    Fplus = zeros(1,9);
    FplusExtra = zeros(1,9);
           
    % Number of frames (assuming the first frame is 1)
    nFrames = min(maxFrames,max(F(:,2)));
    
    % Matrix to store motion estimates
    PcamPlus = zeros(3,4,nFrames,window);
    PcamPlus(:,:,1,1) = [eye(3),[0;0;0]];
    KBA = zeros(3,3,nFrames);
    
    fprintf('Total FRAMES: %d\n', nFrames);
    
    % Match every frame with the next n frames (n defined by window)
    for (i=1:nFrames)
        
        
        % Match current frame i with the next i+window frames        
        for(j=i+1:min(i+window,nFrames))
            
            fprintf('Matching FRAME %d with FRAME %d \n',i,j);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%% MATCH FEATURES %%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % Features in frame 1
            F1 = F(F(:,2)==i,:);
            % Features in frame 2
            F2 = F(F(:,2)==j,:);
            
            % Match them
            
            % Standard VERY SLOW Lowes code.
            if(strcmp(MATCHINGMETHOD,'MATLAB'))
                [i1,i2,numOfMatches] = matchSIFT(F1(:,3:130),F2(:,3:130), distRatio);
            
            % Software from Andrea Vedaldi, 40% faster    
            elseif(strcmp(MATCHINGMETHOD,'VEDALDI'))
                [m1,m2] = siftmatch(F1(:,3:130)',F2(:,3:130)', 1/distRatio);
                i1 = m1(1,:)';
                i2 = m1(2,:)';
                
            % VL_FEAT matching (slightly faster than Vedaldi software)    
            elseif(strcmp(MATCHINGMETHOD,'VL_FEAT'))
                [matches, scores] = vl_ubcmatch(F1(:,3:130)', F2(:,3:130)', 1/distRatio);
                i1 = matches(1,:)';
                i2 = matches(2,:)';   
            end;
            
            numOfMatches = size(i1,1);
            
            fprintf('Initial matches %d:\n',numOfMatches);
            
            % Arrange point matches
            X1 = ones(3,numOfMatches);
            X2 = ones(3,numOfMatches);

            X1(1:2,:) = [F1(i1,132)';F1(i1,131)'];
            X2(1:2,:) = [F2(i2,132)';F2(i2,131)'];

            % Store RGB (average between 2 features)
            R = (F1(i1,135)+F2(i2,135))./2;
            G = (F1(i1,136)+F2(i2,136))./2;
            B = (F1(i1,137)+F2(i2,137))./2;
            
            % Store brute force matches (for a richer 3d model)
            newEntryExtra = [ones(size(X1,2),1).*i,ones(size(X1,2),1).*j,X1(1:2,:)',X2(1:2,:)',R,G,B];
            FplusExtra(end+1:end+size(X1,2),:) = newEntryExtra;
            

            %% REJECT OUTLIERS
            fprintf('REJECTING OUTLIERS USING RANSAC\n');
            % Find the fundamental matrix using RANSAC
            if(strcmp(motionAlgorithm,'8pts'))
                if(j==i+1)
                    [Fund,inliers] = ransacF(X1,X2,ransacIterations,ransacThreshold);
                else
                    [Fund,inliers] = ransacF(X1,X2,10,1000);
                end;
            elseif(strcmp(motionAlgorithm,'5pts'))
                [Fund,inliers] = ransacFfive(X1,X2,ransacIterations,ransacThreshold,K);
            elseif(strcmp(motionAlgorithm,'5ptsFast'))
                [Fund,inliers] = ransacFfiveFast(X1,X2,ransacIterations,ransacThreshold,K);
            elseif(strcmp(motionAlgorithm,'5pts8'))
                [Fund,inliers] = ransacFfive8(X1,X2,ransacIterations,ransacThreshold,K);
            else
                %[Fund,inliers] = ransacF(X1,X2,ransacIterations,ransacThreshold,K);
                inliers = 1:size(X1,2);
                Fund = ones(3,3);
            end;
            
            X1inliers = X1(:,inliers);
            X2inliers = X2(:,inliers);
            
            % Store the matches
            newEntry = [ones(size(inliers,2),1).*i,ones(size(inliers,2),1).*j,X1inliers(1:2,:)',X2inliers(1:2,:)',R(inliers),G(inliers),B(inliers)];
            Fplus(end+1:end+size(inliers,2),:) = newEntry;
                        
        
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%% COMPUTE MOTION %%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            

            fprintf('COMPUTING MOTION\n');
            if(length(inliers)>=8)
            
                % Get E for all possible Fs
                
                PXcam = zeros(3,4,1);
                Etotal = zeros(3,3,1);
                
                for(e=1:size(Fund,3))
                
                    % Compute motion and store
                    % Obtain essential matrix
                    E = K'*Fund(:,:,e)*K;

                    % Ensure we can convert it to rotation and translation by forcing both
                    % non zero eigenvalues to be equal (the average of both)
                    [U,S,V] = svd(E);
                    m = (S(1,1)+S(2,2))/2;
                    E = U*[m,0,0;0,m,0;0,0,0]*V';
                    
                    % Obtain the second camera matrices 
                    tmp1 = getCameraMatrixHorn(E);
                    PXcam(:,:,end+1:end+4) = tmp1;
               
                    
                    Etotal(:,:,end+1:end+1) = E;
                    Etotal(:,:,end+1:end+1) = E;
                    Etotal(:,:,end+1:end+1) = E;
                    Etotal(:,:,end+1:end+1) = E;

                end;
                
                           
                % Check the correct one(the right one out of 4 possible
                % solutions)
                tmp = getCorrectCameraMatrix(PXcam(:,:,2:end), Etotal(:,:,2:end), K, K,[X1inliers;X2inliers]);
                [PcamPlus(:,:,i+1,j-i)] = tmp;

                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%% BUNDLE ADJUSTMENT %%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if(j==i+1 && runBA)
                    
                    fprintf('ITERATIVE REFINEMENT\n');
                    
                    [Pcam2BA,KBAtmp] = bundleAdjust(PcamPlus(:,:,i+1,1),X1inliers',X2inliers',K,BAiterations);
                    PcamPlus(:,:,i+1,1) = Pcam2BA;
                    KBA(:,:,i+1) = KBAtmp;

                end;
                
            else
                
                PcamPlus(:,:,i+1,j-i+1) = zeros(3,4);
                
            end;
            
            
            
        end;
        
    end;
    
    
    PcamX = PcamPlus(:,:,:,1);
    KBA(:,:,1) = K;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    

    
    
