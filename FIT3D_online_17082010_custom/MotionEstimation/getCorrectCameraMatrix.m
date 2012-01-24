% getCorrectCameraMatrix - Check which of the 4 solutions from the
% essential matrix is the correct one.
%
%
% Given the Essential matrix and its decomposition into 4 posible solutions
% the appropiate solution is found using a voting mechanism in which each
% point correspondance votes for one solution based on the position of the
% reconstructed point, which must be in front of both cameras. Camera one
% is assumed to be [I|0].
%
%
% Input  - PXcam  -> (3x4xn) Possible camera solutions
%        - E      -> (3x3xn) Essential matrix that generated the Pcam
%        - K1     -> (3x3) Camera calibration of image 1
%        - K2     -> (3x3) Camera calibration of image 2
%        - X      -> (3*2xn) homogeneous points in images 2 and 1
%
% Output - P      -> (3x4) Correct camera matrix (rotation and translation)
%        - voting -> (4x1) Votes for each solution
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [P,voting] = getCorrectCameraMatrix(PXcam,E, K1,K2, X)

    voting = zeros(size(PXcam,3),1);
    votingB = zeros(size(PXcam,3),1);

    % For every correspondence
    for i=1:size(X,2)

        % Two matching points in image coordinates (x in image 1 and xp in
        % image 2)
        x = X(1:3,i);
        xp = X(4:6,i);

        % The first camera matrix is taken P = [I|0] and the other 
        Pcam = [eye(3),zeros(3,1)];
        P = K1*Pcam;
        xhat = inv(K1)*x;
        

        % For each camera matrix (PXcam), reproject the pair of points in 3D
        % and determine the depth in 3D of the point
        X3D = zeros(4,4);
        Depth = zeros(size(PXcam,3),2);
        
        b = zeros(size(PXcam,3),1);
        c = zeros(size(PXcam,3),1);
        d = zeros(size(PXcam,3),1);
        

        
        for p=1:size(PXcam,3)

            % First the point is converted
            xphat = inv(K2)*xp;

            % We build the matrix A
            A = [Pcam(3,:).*xhat(1,1)-Pcam(1,:);
                 Pcam(3,:).*xhat(2,1)-Pcam(2,:);
                 PXcam(3,:,p).*xphat(1,1)-PXcam(1,:,p);
                 PXcam(3,:,p).*xphat(2,1)-PXcam(2,:,p)];

            % Normalize A
            A1n = sqrt(sum(A(1,:).*A(1,:)));
            A2n = sqrt(sum(A(2,:).*A(2,:)));
            A3n = sqrt(sum(A(3,:).*A(3,:)));
            A4n = sqrt(sum(A(4,:).*A(4,:))); 
            Anorm = [A(1,:)/A1n;
                     A(2,:)/A2n;
                     A(3,:)/A3n;
                     A(4,:)/A4n];

            % Obtain the 3D point
            [Uan,San,Van] = svd(Anorm);
            X3D(:,i) = Van(:,end);

            % Check depth on second camera
            xi = PXcam(:,:,p)*X3D(:,i);
            w = xi(3);
            T = X3D(end,i);
            m3n = sqrt(sum(PXcam(3,1:3,p).*PXcam(3,1:3,p)));
            Depth(p,1) = (sign(det(PXcam(:,1:3,p)))*w)/(T*m3n);

            % Check depth on first camera
            xi = Pcam(:,:)*X3D(:,i);
            w = xi(3);
            T = X3D(end,i);
            m3n = sqrt(sum(Pcam(3,1:3).*Pcam(3,1:3)));
            Depth(p,2) = (sign(det(Pcam(:,1:3)))*w)/(T*m3n);

            %% This check is not currently used but it checks the
            %% constrains on the solution E.
            % Check the constraints
            Et = E(:,:,p);
            Ft = inv(K2)'*Et*inv(K2);

            b(p)=det(Et);             
            prod= Et*Et'*Et;
            c(p)=norm(2 * prod - trace(prod));  

            dd=diag( xhat'*Et*xphat); 
            d(p)=norm(dd);

        end;


        % Voting
        %bT = 10e10;
        %dT = 10e10;
        %cT = 10e10;
        %voteC = 1;
        for(p=1:size(PXcam,3))
            
            % Vote based on depth
            if(Depth(p,1)>0 && Depth(p,2)>0)
                voting(p) = voting(p)+1;
            end;
            
            
            % Vote for constraints (NOT USED)
            %if (b(p)+d(p)+c(p) <= cT+bT+dT)
            %if (b(p)*d(p)*c(p) < cT*bT*dT)
            %if (b(p) < bT && d(p) < dT && c(p) < cT)
            %if d(p) <= dT
            %    bT = b(p);
            %    dT = d(p);
            %    cT = c(p);
            %    voteC = p;
            %end;    
        end;


    
    end;
    
    % Get most voted solutions
    P = PXcam(:,:,find(voting==max(voting)));
    
    % In case of draw, pick the first one (rarely happens)
    if(size(P,3)>1)
        P = P(:,:,1);
    end;

    
    
    
    
    
    
    
    
    
    
    
    
