% findScale - Given a set of 3D points, 3 frames and the corresponding
% matches, find the correct scale of the 3rd camera
%
%
% The scale is computed in closed form with a 1 point algorithm. When more
% 2D-3D correspondences are available a least square solution is obtained.
% For more info refer to Esteban-ICIRA(2010). The reference paper is also
% available at www.fit3d.info.
%
%
% Input  - Pcam  -> (3x4) Camera position   
%        - X3D   -> (nx3) 3D points
%        - Q     -> (nx2) Image points
%        - K     -> (3x3) Camera calibration
%
% Output - scale -> (1x1) Scaling factor
%        - Pcam  -> (3x4) Scaled camera matrix
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010
%
% NOTE: this method is patented under patent number 08172389.2


function [scale,PcamS,rest,scale2,scale3,scale4] = findScaleLinear(Pcam,X3D,Q,K)

    % Put points in space K-1 x Q
    Qw = inv(K)*Q';
    X3Dr = X3D;
    X3D = X3D';
    
    Q = Q'; 
    
    % Project 3D points in image:
    Pw = Pcam*[X3D;ones(1,size(X3D,2))];
    P = K*Pw;
    P = P./repmat(P(3,:),3,1);
    
    % Build matrix A and vector b
     A = [];
     b = [];
     for (i=1:size(X3D,2))
         
         A = [A;Pcam(3,4)*Qw(1,i)-Pcam(1,4);];
         b = [b;(Pcam(1,1:3)-Pcam(3,1:3)*Qw(1,i))*X3D(1:3,i)];
         
         %A = [A;Pcam(1,4)-Pcam(3,4)*Qw(1,i);];
         %b = [b;-(Pcam(1,1)*X3D(1,i)+Pcam(1,2)*X3D(2,i)+Pcam(1,3)*X3D(3,i)-Pcam(3,1)*X3D(1,i)*Qw(1,i)-Pcam(3,2)*X3D(2,i)*Qw(1,i)-Pcam(3,3)*X3D(3,i)*Qw(1,i))];
     end;
    
    % Carsten derivation (the same as SVD)
    x2 = (A'*b)/(A'*A);

    scale = x2;
    PcamS = [Pcam(:,1:3),scale*Pcam(:,4)];
    
    rest = A*x2-b;




%% SECOND METHOD, using V
    % Build matrix A and vector b
     A = [];
     b = [];
     for (i=1:size(X3D,2))
         A = [A;Pcam(3,4)*Qw(2,i)-Pcam(2,4);];
         b = [b;(Pcam(2,1:3)-Pcam(3,1:3)*Qw(2,i))*X3D(1:3,i)];
     end;
     scale2 = (A'*b)/(A'*A);
     
%% THIRD METHOD USING BOTH

    A = [];
     b = [];
     for (i=1:size(X3D,2))
         TMP1 = (Pcam(1:2,1:3)*X3D(1:3,i)-(Pcam(3,1:3)*X3D(1:3,i))*Qw(1:2,i));
         TMP2 = Pcam(3,4)*Qw(1:2,i)-Pcam(1:2,4);
         A = [A;TMP2];
         b = [b;TMP1];
     end;
     scale3 = (A'*b)/(A'*A);

%% METHOD 4
     A = [];
     b = [];
     for (i=1:size(X3D,2))
         A = [A;Pcam(2,4)*(Qw(1,i)/Qw(2,i))-Pcam(1,4);];
         b = [b;(Pcam(1,1:3)-Pcam(2,1:3)*(Qw(1,i)/Qw(2,i)))*X3D(1:3,i)];
     end;
     scale4 = (A'*b)/(A'*A);
