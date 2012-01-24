% eightpoint - 8 Point algorithm for estimating the Fundamental matrix
%
%
% Computes the fundamental matrix F given a set of at least 8 image point 
% correspondaces following the 8-point algorithm described by Zisserman in p282.
%
%
% Input  - X1 -> (3xn) set of homogeneous points in image A
%        - X2 -> (3xn) set of homogeneous points in image B
%
% Output - F  -> (3x3) fundamental matrix 
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function F = eightpoint(X1, X2)

    % Normalize the points following the centroid normalization recommended
    % by Zisserman (p109, p282)
    [X1t,T1] = normalize2Dpoints(X1);
    [X2t,T2] = normalize2Dpoints(X2);
    
    
    % Arrange the matrix A. Only the first two equations are needed as the
    % last one is redundant
    A = zeros(size(X1t,2),9);
    for i=1:size(X1t,2)
        A(i,:) = [X2t(1,i)*X1t(1,i),X2t(1,i)*X1t(2,i),X2t(1,i),X2t(2,i)*X1t(1,i),X2t(2,i)*X1t(2,i),X2t(2,i),X1t(1,i),X1t(2,i),1];
    end;
    
    %% Find the fundamental matrix F' in 2 steps
    if(sum(sum(isnan(A)))==0)
        
        % Compute Â. Â is closest to A in frobenius form 
        %[U,D,V] = svd(A);
        %D(end,end) = 0;
        %Af = U*D*V';
        Af = A;
        
        % Linear solution: Determine F from the singular vector corresponding
        % to the smaller singular value of Â
        [Ua,Da, Va] = svd(Af);
        
         % The matrix F' is composed of the elements of the last vector of V
        f = Va(:,end);

        % Reorganice h to obtain H
        Fp = reshape(f,3,3)';
        
        % Constraint enforcement: Replace F by F' such that det(F´)=0 using
        % SVD
        [Uf,Df,Vf] = svd(Fp);
        %m = mean([Df(1,1),Df(2,2)]);
        %Df(1,1) = m;
        %Df(2,2) = m;
        Df(end,end) = 0;
        Ff = Uf*Df*Vf'; 
        % Denormalization
        F = T2'*Ff*T1;
    else
        'ERROR!!!'
        F = [0/0,0/0,0/0;0/0,0/0,0/0;0/0,0/0,0/0];
    end;

