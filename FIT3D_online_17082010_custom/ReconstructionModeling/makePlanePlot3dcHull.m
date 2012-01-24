% makePlanePlot3dcHull - Given a set of points/images and a plane,
% the texture is computed.
%
%
%
% Input  - b        -> (1x4) Plane parameters
%        - step     -> (1x1) Calibration matrix
%        - x3d      -> (nx3) 3D points that generated the plane
%        - Files    -> (struct) Struct containing image information
%        - im       -> (1x1) Image index to use for texturing
%        - PcamABS  -> (3x4xn) Absolute camera matrices
%        - centers  -> (nx3) Camera centers
%
%
%
% Output - MAPx     -> (nx9) Textured set of 3D points
%        - MAPc     -> (nx9) Colored set of 3D points
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [MAPx,MAPc] = makePlanePlot3dcHull(b,step,x3d,Files,im,PcamABS,K, centers)


    
    

    % Find max and min X and Y
    minX = min(x3d(:,1));
    maxX = max(x3d(:,1));
    minY = min(x3d(:,2));
    maxY = max(x3d(:,2));
    minZ = min(x3d(:,3));
    maxZ = max(x3d(:,3));

    dX = maxX-minX;
    dY = maxY-minY;
    dZ = maxZ-minZ;
    
    stepX = dX/step; 
    stepY = dY/step; 
    stepZ = dZ/step; 
    
    % Build set of points
    X = minX:stepX:maxX;
    Y = minY:stepY:maxY;
    Z = minZ:stepZ:maxZ;
    X = X';
    Y = Y';
    Z = Z';
    
    
    % Compute convex hull of 3D points
    indexHull = convhull(x3d(:,1),x3d(:,2));
 
    
    % initialize map
    MAPx = [];
    MAPc = [];
    
    
    for(ii=im(1):im(2))
    
        PcamInv = inv([PcamABS(:,:,ii);0,0,0,1]);
        PcamInv = PcamInv(1:3,:);
        
        % Define 3 points in the image
        P1 = inv(K)*[100;0;1];
        P2 = inv(K)*[0;100;1];
        P3 = inv(K)*[100;100;1];
        
        % Get Image plane normal
        [N,X2imageplane2 ]= getImagePlaneNormal(P1,P2,P3,PcamABS(:,:,ii));
                
        % Get image
        img = imread(strcat(Files.dir,Files.files(ii).name));

        MAPl = [];
       
        % For every pixel in the plane...
        Rc = floor(rand*254);
        Gc = floor(rand*254);
        Bc = floor(rand*254);

        for(i=1:size(X,1))
            for(j=1:size(Y,1))

                % Calculate Z coordinate
                Z = (b(1)*(X(i)) + b(2).*(Y(j)) + b(4))./(-b(3));
                
                
                if(inhull([X(i),Y(j)],x3d(indexHull,1:2)))


                    % Trace ray to camera center and find intersection with camera
                    % plane
                    P3D = [X(i);Y(j);Z];
                    C2 = centers(ii,:)';
                    u = (dot(N,(X2imageplane2-C2)))/(dot(N,(P3D-C2)));
                    Q3D = C2+u*(P3D-C2);

                    
                    
                    %MAPx = [MAPx;[C2',0,1,0,1,1,1]];

                    %MAPx = [MAPx;[Q3D',1,0,0,1,1,1]];
                    
                    % Transfer back to origin
                    Q3Do = PcamInv(:,1:3)*Q3D+PcamInv(:,4);
                    %Q3Do = Q3D-centers(ii,:)';

                    
    
                    %MAPx = [MAPx;[Q3Do',1,1,0,1,1,1]];
    
                    %Q3Do
                    %pause
                    
                    % Get image coordinages
                    %Q3Dim = Q3Do;
                    Q3Dim = K*Q3Do;
                    
                    %Q3Dim
                    
                    %pause

                    % Find angle between image plane normal and ray
                    R1 = P3D-C2;
                    cosA = dot(N,R1)/(norm(R1)*norm(N)); 
                    ang = rad2grad(acos(cosA));

                    % Find distance between 3D point and camera
                    dist = sqrt(sum(R1).^2);

                    % Find angle between image plane normal and plane normal
                    P1 = [1;1;(b(1) + b(2) + b(4))./(-b(3));];
                    P2 = [1;0;(b(1) + b(4))./(-b(3));];
                    P2 = [0;1;(b(2) + b(4))./(-b(3));];

                    [N2,X2imageplane22 ]= getImagePlaneNormal(P1,P2,P3,[eye(3),[0;0;0]]);
                    cosA2 = dot(N,N2)/(norm(N)*norm(N2)); 
                    ang2 = abs(rad2grad(acos(cosA2)));
                    %if(ang2>180)
                    %    ang2 = ang2-180;
                    %end;


                    % Find angle between ray and patch
                    cosA3 = dot(R1,N2)/(norm(R1)*norm(N2)); 
                    ang3 = 90-abs(rad2grad(asin(cosA3)));
                    if(ang3>180)
                        ang3 = ang3-180;
                    end;

                    % Put 3D points in global coords
                    %P3D = PcamABS(:,1:3,ii)'*P3D-PcamABS(:,4,ii);

                    %[ceil(Q3Dim(2)), ceil(Q3Dim(1))]
                    %pause
                    
                    if(Q3Dim(1)>1 && Q3Dim(2)>1 && Q3Dim(1)<size(img,2) && Q3Dim(2)<size(img,1))
                        
                        MAPc = [MAPc;[P3D',double(Rc),double(Gc),double(Bc),1,1,1,ang,dist,ang2,ang3]];
                        
                        
                        
                        R = floor(img(ceil(Q3Dim(2)),ceil(Q3Dim(1)),1));
                        G = floor(img(ceil(Q3Dim(2)),ceil(Q3Dim(1)),2));
                        B = floor(img(ceil(Q3Dim(2)),ceil(Q3Dim(1)),3));



                        MAPl = [MAPl;[P3D',double(R),double(G),double(B),1,1,1,ang,dist,ang2,ang3]];

                    end;
 
                end;
                    
            end;
        end;

        
        
        % If there is no texture yet, put it in
        if(size(MAPx,1)==0)
            MAPx = MAPl;
        else
            % If there is a texture and a new texture comes in, find the
            % corresponding elements and fuse them.
            if(size(MAPl,1)>0)
                
                for(p=1:size(MAPl,1))
                    idx = find(MAPx(:,1)==MAPl(p,1) & MAPx(:,2)==MAPl(p,2) & MAPx(:,3)==MAPl(p,3));

                    if(size(idx,1)==0)
                        
                        MAPx = [MAPx;MAPl(p,:)];
                    elseif(size(idx,1)==1)

                        %'DUPLICATE FOUND'
                        
                        % Average if the distance is below a threshold
                        %if(MAPl(p,end)<5)
                        %    MAPx(idx,4:6) = ceil((MAPx(idx,4:6)+MAPl(p,4:6))./2);
                        %end;
                        
                        % Take the one with minimum angle
                        %if(MAPx(idx,end-1)<MAPl(p,end-1))
                        %    MAPx(idx,4:6) = MAPl(p,4:6);
                        %end;
                        
                        % Take the one with minimum distance
                        %if(MAPx(idx,end)<MAPl(p,end))
                        %    MAPx(idx,4:6) = MAPl(p,4:6);
                        %end;
                        
                        % Take the one with the most paralel planes (image
                        % and patch)
                        %if(MAPx(idx,end)>MAPl(p,end))
                        %    MAPx(idx,4:6) = MAPl(p,4:6);
                        %end;
                        
                        % Take the one with the most perpendicular ray to
                        % the patch
                        %[MAPx(idx,end),MAPl(p,end)]
                        if(MAPx(idx,end)>MAPl(p,end) )
                            fprintf('Changing texture from image %d\n',ii);
                            
                            MAPx(idx,4:6) = MAPl(p,4:6);
                        end;
                        
                        % Average
                        %MAPx(idx,4:6) = ceil((MAPx(idx,4:6)+MAPl(p,4:6))./2);
                        %MAPx(idx,4:6) = MAPl(p,4:6);
                    end;
                end;
                %MAPx(idx,4:6) = ceil((MAPx(:,4:6)+MAPl(:,4:6))./2);
            end;
        end;

    end;
    %MAPx = MAP;
    %MAPx = ones(size(MAP,1),9);
    %MAPx(:,1:3) = MAP;

    if(size(MAPx,2)>1)
        MAPx = MAPx(:,1:9);
    else
        MAPx = [];
    end;
