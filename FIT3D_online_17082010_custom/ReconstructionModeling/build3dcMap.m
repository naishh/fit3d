% build3dcMap - Given the. image matches and the camera motions, a 3dc map
% is built
%
% This function builds a complete 3D model. There are 3 different steps.
% Step one (plotFrames) will create a 3D map with the images displayed in
% space. Step 2 will create the 3D containing the pointcloud. 
% Step 3 (fitPlanes) will attempt to represent the pointcloud with
% planar patches. Please refer to our paper for more information.
%
%
% Input  - Fplus        -> (nx9) n features x [frame1,frame2,X1,Y1,X2,Y2,R,G,B]
%        - Pcam         -> (3x4xk) camera matrices in relative frame for k camera poses 
%        - K            -> (3x3) camera calibration matrix
%        - Files        -> (structxk) struct containing the name of the image files for plotting in the point cloud 
%        - dist         -> (1x1) show points within distance
%        - plotFrames   -> (true/false) Plot the images positioned in space
%        - plotPoints   -> (true/false) Plot the point cloud
%        - fitPlanes    -> (true/false) Use the plane fitting algorithm
%        - nplanes      -> (1x1) Number of iterations to ron the plane
%                                fitting algorithm
%        - fitthreshold -> (1x1) Fitting threshold for the planes
%        - density      -> (1x1) Density of the displayed planes
%        - points       -> (1x1) Maximum number of points to select at every
%                          iterations
%        - minpoints    -> (1x1) Minimum number of points requiered for a
%                          plane
%        - planeransac  -> (1x1) Ransac iterations for plane fitting
%        - maxDist      -> (1x1) Maximum distance from points to mean
%        - startFrame   -> (1x1) Starting frame
%
% Output - MAP          -> the 3D map
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function MAP = build3dcMap(FplusExtra, PcamI, Km, Files, dist1, plotFrames,plotPoints,fitPlanes,nplanes,fitthreshold,density,points,minpoints,planeransac,maxDist,startFrame)

    % Inver the motion
    Pcam = invertMotion(normalizePcam(PcamI));

    % Number of framesrh2lh
    frames = size(Pcam,3);
    
    % Absolute Pcam
    [PcamABS] = getTrajectory3DNorm(Pcam);

    b = PcamABS(:,1:3,:);
    centers = reshape(PcamABS(:,4,:),3,size(PcamABS,3))';
    

    
    PcamInv = normalizePcam(Pcam);
    for(i=1:size(Pcam,3))
        PcamInv(:,:,i) = inv(PcamInv(:,:,i));
    end;
    PcamInv = PcamInv(1:3,:,:);
 
    [PcamABSInv] = getTrajectory3DNorm(PcamInv);
    
    MAP = [];
    POINTCLOUD = [];
    POINTCLOUDidx = [];
    
    MAPc = [];
    
    % For every frame
    for(i=startFrame:frames-1)
        
        if(size(Km,3)==1)
            K = Km;
        else
            K = Km(:,:,i);
        end;
        
        %%%%%%%%%%%%%%%
        % POINT CLOUD %
        %%%%%%%%%%%%%%%
        
        % Find all matches between frames
        P = FplusExtra(find(FplusExtra(:,1)==i & FplusExtra(:,2)==i+1),3:4);
        P = [P,ones(size(P,1),1)];
        Q = FplusExtra(find(FplusExtra(:,1)==i & FplusExtra(:,2)==i+1),5:6);
        Q = [Q,ones(size(Q,1),1)];
        
        % Get image indexes
        indxAllFeatures = FplusExtra(find(FplusExtra(:,1)==i & FplusExtra(:,2)==i+1),1);
        
        % Get RGB values
        R = FplusExtra(find(FplusExtra(:,1)==i & FplusExtra(:,2)==i+1),7);
        G = FplusExtra(find(FplusExtra(:,1)==i & FplusExtra(:,2)==i+1),8);
        B = FplusExtra(find(FplusExtra(:,1)==i & FplusExtra(:,2)==i+1),9);

        % Triangulate points
        x3d = findTriangulationLM(P,Q,[eye(3),[0;0;0]],PcamInv(:,:,i+1),K,K)';
        
        
        % Find points which distance to the camera center is below the
        % threshold
        d = sqrt(x3d(:,1).^2+x3d(:,2).^2+x3d(:,3).^2);
        x3d = x3d(d<dist1,:);
        indxFeatures = indxAllFeatures(d<dist1);
        
        R = R(d<dist1,:);
        G = G(d<dist1,:);
        B = B(d<dist1,:);
        
        
        % Put points in absolute coordinates
        for(f=1:size(x3d,1))
            x3d(f,1:3) = (PcamABS(:,1:3,i)*x3d(f,1:3)'+PcamABS(:,4,i))';
        end;
            
        
        
        % Create map
        MAPlocal = [x3d(:,1:3),floor(R*255),floor(G*255),floor(B*255),ones(size(x3d,1),3)];
        if(plotPoints)
            %MAP = [MAP;MAPlocal];
        end;
        POINTCLOUD = [POINTCLOUD;MAPlocal];
        POINTCLOUDidx = [POINTCLOUDidx;indxFeatures];
        
        
    end;
    
    % Plot images if requested (heavy on the 3dc file)
    MAPframes = [];
    if(plotFrames)
        
        % Absolute Pcam
        %[centers,b,PcamABS] = getTrajectory3D(Pcam);
        
        for(i=1:frames-1)
            
            PcamInv = inv([PcamABS(:,:,i);0,0,0,1]);
            PcamInv = PcamInv(1:3,:);
            
            if(size(Km,3)==1)
                K = Km;
            else
                K = Km(:,:,i);
            end;
            
            % Read the image
            strcat(Files.dir,Files.files(i).name)
            img = imread(strcat(Files.dir,Files.files(i).name));
            % subsample rate
            subsample = 6;

            % Prepare map
            imgMAP = zeros(length(1:subsample:size(img,2))*length(1:subsample:size(img,1)),9);
            counter = 1;
            % obtain 3D points of the image
            for m=1:subsample:size(img,2)
                for n=1:subsample:size(img,1)
                    % Put in camera center coords
                    aa = inv(K)*[m;n;1];
                    % Move them to the camera 1 reference frame
                    aa = PcamABS(:,1:3,i)*aa+PcamABS(:,4,i);
                    if(size(img,3)==1)
                        R = floor(img(n,m));
                        G = R;
                        B = R;
                    else
                        R = floor(img(n,m,1));
                        G = floor(img(n,m,2));
                        B = floor(img(n,m,3));
                    end;
                    imgMAP(counter,:) = [aa',double(R),double(G),double(B),ones(1,3)];
                    counter = counter+1;
                end;
            end;
            size(imgMAP);
            MAPframes = [MAPframes;imgMAP];
        end;
    end;
    
    

    
    % METHOD 2, fit n planes to the whole point cloud
    foundPlanes = 0;
    METHOD2 = false;
    MAPplanes = [];
    
    if(fitPlanes)

        % Get all points
        totalX3D = POINTCLOUD(:,1:3);
        
        x3dToFit = totalX3D;

        % Number of closest points
        npts = points;

        minpointsLocal = minpoints;
               
        subsetx3dToFit = x3dToFit;
        
        % Get as many planes as requested
        for(np=1:nplanes)
            
            %size(x3dToFit)
            fprintf('Iteration: %d\n',np);
            fprintf('Size: %d\n',size(x3dToFit,1));
            fprintf('npts: %d\n',npts);
            
            
            % If there are enough points
            if(size(x3dToFit,1)>minpointsLocal)

                % Choose a random point
                n = getNRandom(1,size(x3dToFit,1));

                % Get closest points
                closest = ipdm(x3dToFit,x3dToFit(n,:),'Subset','smallestfew','limit',min(npts,size(x3dToFit,1)));

                % Get those points
                subsetx3dToFit = x3dToFit(full(closest)~=0 & full(closest)<maxDist,:);
                subsetIdx = POINTCLOUDidx(full(closest)~=0 & full(closest)<maxDist,:);
                                 
                % Alternative method using ALL points
                %subsetx3dToFit = x3dToFit;
                %subsetIdx = POINTCLOUDidx;

                % Get rid of poitns too far away from the pointcloud
                % centroid
                centroid = mean(subsetx3dToFit);
                
                % calculate distances and mean distance
                D = ipdm(subsetx3dToFit,centroid);
                meanD = median(D);
                
                % Eliminate points that are further than mean
                subsetx3dToFit = subsetx3dToFit(D<meanD,:);
                subsetIdx = subsetIdx(D<meanD,:);
                
                
                % If the size of the set is enough 
                if(length(subsetx3dToFit)>minpointsLocal)

                    % Fit plane
                    [B,P,inliers, warning] = ransacfitplane(subsetx3dToFit',fitthreshold,0,minpoints,planeransac);

                    %if(warningcounter>100 && minpointsLocal>20)
                    %if(warningcounter>30)
                    %    minpointsLocal = minpointsLocal-ceil(minpointsLocal/5);
                        %maxDist = maxDist+maxDist*0.2;
                    %    warningcounter = 1;
                    %end;

                    if(length(inliers)>minpointsLocal)
                        foundPlanes = foundPlanes+1;
                        fprintf('Plane found, determining texture\n');

                        % Select the picture
                        indx = floor(max(subsetIdx(inliers,:)));

                        % Find proyection for texture
                        [MAPplane,MAPplaneColor] = makePlanePlot3dcHull(B,density,subsetx3dToFit(inliers,1:3),Files,[floor(median(subsetIdx(inliers,:))),floor(median(subsetIdx(inliers,:)))],PcamABS,K,centers);

                        % Add map
                        MAPplanes = [MAPplanes;MAPplane];
                        MAPc = [MAPc;MAPplaneColor];

                        % Uncomment this to export all planes in a
                        % different file!
                        %dlmwrite(['3dmapPlaneC' num2str(np) '.3dc'],MAPplaneColor,' ');
                        %dlmwrite(['3dmapPlane' num2str(np) '.3dc'],MAPplane,' ');

                        % Remove inliers
                        [x3dToFit,I] = setdiff(x3dToFit(:,:),subsetx3dToFit(inliers,:),'rows');
                        POINTCLOUDidx = POINTCLOUDidx(I,:);

                    end;

                end;


            end;

        end;
    end;
    
   
    
    if(plotPoints)

        if(size(MAP,1)==1)
            MAP = POINTCLOUD;
        else
            MAP = [MAP;POINTCLOUD];
        end;
    end;

    
    % Write file
    fprintf('Writing 3DC file');
    if(size(POINTCLOUD,1)>0)
        dlmwrite('3dmap.3dc',POINTCLOUD,' ');
    end;
    if(size(MAPplanes,1)>0)
        dlmwrite('3dmapPlane.3dc',MAPplanes,' ');
    end;
    if(size(MAPc,1)>0)
        dlmwrite('3dmapPlaneC.3dc',MAPc,' ');
    end;
    if(size(MAPframes,1)>0)
        dlmwrite('3dmapFrames.3dc',MAPframes,' ');
    end;
    
    
    
    
    
