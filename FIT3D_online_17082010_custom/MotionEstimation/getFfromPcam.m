% getFfromPcam - Given the camera matrix as [R|T] computes the
% corresponding fundamental matrix. The Pcam must be expressed as the
% camera position wrt to [I|0].
%
%
%
%
% Input  - Pcam -> (3x4xk) k camera matrices
%        
% Output - F    -> (3x3xk) Corresponding fundamental matrices
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function F = getFfromPcam(Pcam)

    % Reserve space
    F = zeros(3,3,size(Pcam,3));

    % For every camera matrix
    for(i=1:size(Pcam,3))
        
        [U,S,V] = svd([eye(3),[0;0;0]]);
        C = V(:,end);
        
        e = Pcam(:,:,i)*C;
        
        ex = [0,-e(3),e(2);
              e(3),0,-e(1);
              -e(2),e(1),0];           
        
        F(:,:,i) = ex*Pcam(:,:,i)*pinv([eye(3),[0;0;0]]);
        
        
    end;
