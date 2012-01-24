% findScale3D - Given a set of 3D points, 3 frames and the corresponding
% matches, find the correct scale of the 3rd camera
%
%
% Compute the scale by minimizing the point-to-point distances of 2
% corresponding point clouds.
%
%
% Input  - Pcam2   
%        - Pcam3   
%        - X3D
%        - P
%        - Q
%        - R
%
% Output - scale 
%        - Pcam
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function [scale,Pcam] = findScale3D(Pcam3,X3D,Q,R,K)

    % The idea is to minimize the reprojection error, given the 3D points,
    % the image features and the camera matrix, adjusting only the scale of
    % the translation
    
    
    % Minimize the cost function 
    r = 5000;
    options = optimset('Display','iter','MaxIter',r,'MaxFunEvals',r,'TolX',1.90744e-28);
    scale = lsqnonlin(@(s) get3Derror(X3D,Q,R,Pcam3,s,K),1,-1000000,10000000,options);

    
    Pcam = [Pcam3(:,1:3),scale*Pcam3(:,4)];
    
    function e = get3Derror(X3D,Q,R,Pcam3,s,K)
                
        % Get new camera motion
        Pcam3s = [Pcam3(:,1:3),s*Pcam3(:,4)];
        
        % Triangulate points
        x3d = findTriangulationLM(Q,R,[eye(3),[0;0;0]],Pcam3s,K,K)';
        
        %plot3(x3d(:,1),x3d(:,2),x3d(:,3),'bo');
        %hold on;
        %plot3(X3D(:,1),X3D(:,2),X3D(:,3),'rx');
        %hold off;
        %pause
        
        % Obtain error
        e = [(X3D(:,1)-x3d(:,1)).^2+(X3D(:,2)-x3d(:,2)).^2+(X3D(:,3)-x3d(:,3)).^2];
        %e = [(X3D(:,1)-x3d(:,1)),(X3D(:,2)-x3d(:,2)),(X3D(:,3)-x3d(:,3))];
 
