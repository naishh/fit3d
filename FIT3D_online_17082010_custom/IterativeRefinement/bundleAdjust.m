% bundleAdjust - ...
%
%
% More info
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


function [PcamBA,KBA] = bundleAdjust(Pcam,P,Q,K,r)

    
    % Get 3D points
    X3D = findTriangulationLM(P,Q,[eye(3),[0;0;0]],Pcam,K,K)';
    
    
    
    % Set in quaternion format
    %Pcamv = [Pcam(1,1);Pcam(1,2);Pcam(1,3);Pcam(2,2);Pcam(2,3);Pcam(3,3);Pcam(:,4)];
    Pcamv = fromPcamToVector(Pcam);
    Kv = [K(1,1);K(2,2);K(1,3);K(2,3)];
    
    %Pcam
    %Pcamv
    %pause
    
    % Minimize the cost function 
    options = optimset('Display','iter','MaxIter',r,'MaxFunEvals',r,'TolX',1.90744e-20,'TolFun',1.90744e-20);
    [p,rn,residual] = lsqnonlin(@(p) getReproError(X3D(:,1:3),P,Q,p,K),[Pcamv;Kv],[],[],options);

    %size(residual)
    %pause
    %residual
    
    %plot(residual)
    %pause
    
    %PcamBA = [[p(1),p(2),p(3);
    %          -p(2),p(4),p(5);
    %          -p(3),-p(5),p(6)]];
    %PcamBA = [PcamBA,p(7:9)];
    
    %PcamBA = [Rmq(p(1:4)),p(5:7)];
    PcamBA = fromVectorToPcam(p(1:end-4));
    Kp = p(end-3:end);
    KBA = [Kp(1),0,Kp(3);0,Kp(2),Kp(4);0,0,1];
    [K;KBA]
    %PcamBA = p;
    
    function e = getReproError(X3D,P,Q,pv,K)
                    
        pixelDistance = 2;
        
        
        % Put in matrix format
        %p = [[pv(1),pv(2),pv(3);
        %      -pv(2),pv(4),pv(5);
        %      -pv(3),-pv(5),pv(6)]];
        %p = [p,pv(7:9)];
        %p = [Rmq(pv(1:4)),pv(5:7)];

        p = fromVectorToPcam(pv(1:end-4));
        Kp = pv(end-3:end);
        K = [Kp(1),0,Kp(3);0,Kp(2),Kp(4);0,0,1];
        
        %p = pv;
        
        % Triangulate points
        x3d = findTriangulationLM(P,Q,[eye(3),[0;0;0]],p,K,K)';
        %pause
        % Obtain error
        %e3D = [(X3D(:,1)-x3d(:,1)).^2+(X3D(:,2)-x3d(:,2)).^2+(X3D(:,3)-x3d(:,3)).^2];
        %pause
        %e = [e;getReprojectionErrorSingleImage(Q,x3d,P,1,K)'];
        tmp1 = getReprojectionErrorSingleImage(Q,x3d(:,1:3),p,1,K,false);
        tmp2 = getReprojectionErrorSingleImage(P,x3d(:,1:3),[eye(3),[0;0;0]],1,K,false);
        e1 = tmp1;
        %e1(e1>pixelDistance) = 1e+10;
        e2 = tmp2;
        %e2(e2>pixelDistance) = 1e+10;
        
        e = [e1;e2];
        
        %e = [e;tmp];
        %e = [e3D;tmp];
