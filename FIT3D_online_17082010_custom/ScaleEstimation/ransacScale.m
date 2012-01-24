% ransacScale - RANSAC algorithm for the estimation of the scale
%
%
% Computes the scale using a closed form and applies ransac. See also
% findScaleLinear.
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
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010
%
% NOTE: this method uses a patented technique under patent number 08172389.2

function [s, bestmodel] = ransacScale(Pcam,X3D,Q,K)

    % Parameters
    t = 0.01;
    %t = 0.001;
    N = 1000;
    
    % Best scores
    bestscore = 0;
    bestmodel = [];
    bestscorelist = [];
    bestscale = 0;
    
    
    Qw = inv(K)*Q';
    
    X3Dp = X3D';
   
    % RANSAC
    for(i=1:size(X3D,1))
        
        
        % Get scale
        [scale,Pcam3S] = findScaleLinear(Pcam, X3D(i,1:3), Q,K);



        % Get error
        A = [];
        b = [];
        for (i=1:size(X3Dp,2))
            A = [A;Pcam3S(1,4)-Pcam3S(3,4)*Qw(1,i);];
            b = [b;-(Pcam3S(1,1)*X3Dp(1,i)+Pcam3S(1,2)*X3Dp(2,i)+Pcam3S(1,3)*X3Dp(3,i)-Pcam3S(3,1)*X3Dp(1,i)*Qw(1,i)-Pcam3S(3,2)*X3Dp(2,i)*Qw(1,i)-Pcam3S(3,3)*X3Dp(3,i)*Qw(1,i))];
        end;
        
        dist = A*scale-b;
         
        
        
        %[sum(abs(dist)<t),bestscore]
        %pause
        if(sum(abs(dist)<t)>bestscore)
            bestscore = sum(abs(dist)<t);
            bestmodel = X3D(abs(dist)<t,:);
            bestscorelist = dist;
            bestscale = scale;
        elseif(sum(abs(dist)<t)==bestscore)
            if(sum(abs(dist))<sum(abs(bestscorelist)))
                bestmodel = X3D(abs(dist)<t,:);
                bestscorelist = dist;
                bestscale = scale;
            end;
        end;
        
        
        
    end;
    
    
    %Find scale for best score
    %[scale,Pcam3S] = findScaleLinear(Pcam, X3D, Q,K);
    
    % Get scale with all points
    %[scaleT,Pcam3ST] = findScaleLinear(Pcam, X3D, Q,K);
    
    %x3d1 = findTriangulationLM(P,Q,[eye(3),[0;0;0]],Pcam3ST,K,K)';
    %distT = [sqrt((x3d1(:,1)-X3D(:,1)).^2+(x3d1(:,2)-X3D(:,2)).^2+(x3d1(:,3)-X3D(:,3)).^2)];
    
    %s = bestscale;
    if(bestscore>0)
        [scaleT,Pcam3ST] = findScaleLinear(Pcam, bestmodel, Q,K);
        s = bestscale;
    else
        [scaleT,Pcam3ST] = findScaleLinear(Pcam, X3D, Q,K);
        s = scaleT;
    end;
    
    size(bestmodel)
    

