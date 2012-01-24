% getReprojectionErrorSingleImage - Caculates the reprojection error
%
%
% Calculates the reprojection error given a set of 3D points, image points, 
% and camera calibration. The error is the set of square distances.
%   
%
%
% Input  - imagePoints  -> (nx2) Image points
%        - X3D          -> (nx3) Points in 3D space
%        - Pcam         -> (3x4) Camera matrix
%        - s            -> (1x1) Scale factor for the translation
%        - K            -> (3x3) Camera calibration
%        - debug        -> (true/false) To display debug info
%
%
%
% Output - e           -> (nx1) Square distances from image points to
%                         reprojected points
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010l

function e = getReprojectionErrorSingleImage(imagePoints,X3D,Pcam,s,K,debug)


    % Given the 3D points, find the distance from the image points to
    % the lines that go from the 3D points to the new camera center
    % (scaled)

    e = zeros(size(X3D,1),2);

    C3 = s*Pcam(:,4);
    
    
    
    % Put image points P in the global reference frame
    Pw = zeros(3,size(imagePoints,1));
    for(i=1:size(imagePoints,1))
        Pw(:,i) = inv(K)*imagePoints(i,:)';
        % Move them to C1
        %Pw(:,i) = Pcam(:,1:3)*Pw(:,i)+C3;
    end;
    P = imagePoints';
    
    % Obtain projection of 3D points
    Qw = [Pcam(:,1:3),s*Pcam(:,4)]*[X3D';ones(1,size(X3D,1))];
    Q = K*Qw;
    Q = Q./repmat(Q(3,:),3,1);
    
    % Obtain distances
    %e = (Q-P).^2;
    
    e = sqrt((Q(1:2,:)-P(1:2,:)).^2);
    
    e = e';
        
    
    
    %e = e';
    
    %% DEBUG PLOT
    if(debug)

        %plot3(Pw(1,:),Pw(2,:),Pw(3,:),'bo');
        %hold on;
        %plot3(Qw(1,:),Qw(2,:),Qw(3,:),'rx');
        %plot3(X3D(:,1),X3D(:,2),X3D(:,3),'gx')
        %hold off;
        plot(Q(1,:),Q(2,:),'rx');
        hold on;
        plot(P(1,:),P(2,:),'bo');
        hold off;
        pause;
    end;
 
