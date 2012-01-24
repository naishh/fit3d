% adjustScaleWith3Frames - Given the set of matches (assumed to be from at
% least 1 to 3 frames), the scale is adjusted.
%
%
% We use a closed form solution that solves the scale with as little a one
% 2D-3D correspondence. When more are available, a least square solution is
% found also in closed form. Please refer to the publications in
% www.fit3d.info for a reference paper.
%
%
% Input  - Fplus        -> (nx9) n features x [frame1,frame2,X1,Y1,X2,Y2,R,G,B]
%        - Pcam         -> (3x4xk) camera matrices in relative frame for k camera poses 
%        - K            -> (3x3) camera calibration matrix
%        - distFor3D    -> (1x1) distance to use only some points to
%                                estimating the scale
%        - scaleMethod  -> (string) '3D' or 'reprojection'
%        - startFrame   -> (1x1) Starting frame
%
% Output - PcamScaled   -> (3x4xk) scaled camera matrices in relative frame
%        - pts          -> (Struct) Structure to store all the feature
%                          matches accross 3 frames so they can be used for pointcloud
%                          distance minimization withouth the need for tracking again.
%        - scales       -> (kx1) Calculated relative scales
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [PcamScaled,pts,scales] = adjustScaleWith3Frames(Fplus, Pcam, Km, distFor3D, scaleMethod, startFrame)
    
    

    % Number of frames (assuming the first frame is 1)
    nFrames = size(Pcam,3);
    
    % Storage for scaled camera matrices. The first two cameras are set as
    % they are not scaled (they are the reference for the scale)
    PcamScaled = zeros(3,4,nFrames);
    PcamScaled(:,:,startFrame) = Pcam(:,:,startFrame);
    PcamScaled(:,:,startFrame+1) = Pcam(:,:,startFrame+1);
    PcamScaled(:,4,startFrame+1) = PcamScaled(:,4,startFrame+1)./norm(PcamScaled(:,4,startFrame+1));
    
    for(i=startFrame:nFrames-1)
        tmp1 = Fplus(Fplus(:,2)==i+1,:);
        tmp1 = tmp1(tmp1(:,1)==i,:);
            
        pts(i).P = [tmp1(:,3:4),ones(size(tmp1,1),1)];
        pts(i).Q = [tmp1(:,5:6),ones(size(tmp1,1),1)];   
    end;
    
    scales = [];
    
    % For every frame
    for (i=startFrame:nFrames-2)

        % Select the camera calibration matrix. If more than one is
        % provided, we assume each one is optimized for each camera pose,
        % otherwise a single one is used.
        if(size(Km,3)==1)
            K = Km;
        else
            K = Km(:,:,i);
        end;
        
                
        fprintf('PROCESSING FRAME %d\n',i);
                
        % Get matches from frame i
        matches = Fplus(Fplus(:,1)==i,:);
        
        % Number of matches
        numOfMatches = size(matches,1);
        
        fprintf('Number of features in frame %d: %d\n',i,numOfMatches);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% TRACKING FEATURES %%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Matches between frames 1-2 and 2-3
        matchesF12 = Fplus(Fplus(:,1)==i & Fplus(:,2)==i+1,:);
        matchesF23 = Fplus(Fplus(:,1)==i+1 & Fplus(:,2)==i+2,:);
        
        % Number of matches
        numOfMatches1 = size(matchesF12,1);

        % Store the matches found in the next 2 frames to adjust the scale
        % (frame1,frame2,frame3,X1,Y1,X2,Y2,X3,Y3, R,G,B)
        matches = zeros(1,12);
        
        % For every feature match between frames 1 and 2, try to find it in the matches set
        % between frames 2 and 3
        for (k=1:numOfMatches1)
        
            % Get current feature            
            currentFeature = matchesF12(k,:);
            currentX = currentFeature(5);
            currentY = currentFeature(6);
            
            % Try to find a feature with the same X and Y in F23
            tmp1 = matchesF23(matchesF23(:,3)==currentX & matchesF23(:,4)==currentY,:);
            
            % If found, then add it to the set of 3-frame matches
            if(size(tmp1,1)>0)
                newEntry = [i,i+1,i+2,matchesF12(k,3),matchesF12(k,4),tmp1(1,3),tmp1(1,4),tmp1(1,5),tmp1(1,6),currentFeature(7:9)];
                matches = [matches;newEntry];
            end;
                        
                    
        end;
        
        
        % Delete first row in matches
        matches = matches(2:end,:);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% FINDING SCALE %%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        % If tracks were found, then adjust scale
        if(size(matches,1)>0)
        
            fprintf('Number of 3frame matches: %d\n',size(matches,1));


            % Having found all matches, lets find the scale of frame 3 with
            % respect to frame 2

            % Get camera matrices
            % As we have relative camera matrices, the first camera is always
            % [I|0], and the second one, we take the already scaled one. We
            % normalize to find the relative scale.
            Pcam1 = [eye(3),[0;0;0]];
            Pcam2 = Pcam(:,:,i+1);
            Pcam2(:,4) = Pcam2(:,4)./norm(Pcam2(:,4));
            Pcam3 = Pcam(:,:,i+2);
            Pcam3(:,4) = Pcam3(:,4)./norm(Pcam3(:,4));

            % Get image features for the 3 frames
            P = [matches(:,4:5),ones(size(matches,1),1)];
            Q = [matches(:,6:7),ones(size(matches,1),1)];
            R = [matches(:,8:9),ones(size(matches,1),1)];

            % Store the points
            pts(i).P3 = P;
            pts(i).Q3 = Q;
            pts(i).R3 = R;
            
            % Triangulate points in frame i and i+1
            x3d = findTriangulationLM(P,Q,Pcam1,Pcam2,K,K)';

            % Use only points that are within distance distFor3D
            distance = distFor3D;
            ind = find((x3d(:,1)<distance & x3d(:,1)>-distance) & (x3d(:,2)<distance & x3d(:,2)>-distance) & (x3d(:,3)<distance & x3d(:,3)>-distance));
            x3d = x3d(ind,:);
            fprintf('Number of 3D points for scaling: %d\n',size(x3d,1));
            P = P(ind,:);
            Q = Q(ind,:);
            R = R(ind,:);

            % move 3d points to Pcam2 
            x3dPcam2 = x3d;
            for f=1:size(x3dPcam2,1)
                x3dPcam2(f,1:3) = (Pcam2(:,1:3)*x3dPcam2(f,1:3)'+Pcam2(:,4))';
            end;


            % Find the scale of the third image
            if(strcmp(scaleMethod,'3D'))
                [scale,Pcam3S] = findScale3D(Pcam3, x3dPcam2(:,1:3), Q, R,K);
            elseif(strcmp(scaleMethod,'reprojection'))
                [scale,Pcam3S] = findScaleLinear(Pcam3, x3dPcam2(:,1:3),R ,K);
            elseif(strcmp(scaleMethod,'reproRansac'))
                [scale,Pcam3S] = ransacScale(Pcam3, x3dPcam2(:,1:3),R,K);
            end;
            
                       
            % If the scale is too far from 1, then set it to 1 since it
            % might be an outlier
            if(abs(scale-1)<0.7)
                scales = [scales;scale];
                Pcam3(:,4) = norm(PcamScaled(:,4,i+1))*scale*Pcam3(:,4);
            else
                scales = [scales;1];
            end;
            PcamScaled(:,:,i+2) = Pcam3;
            
            

        else
            fprintf('Skipping frame, no 3 frame tracks\n');
            PcamScaled(:,:,i+2) = Pcam(:,:,i+2);;
        end;

    end;

    

    
