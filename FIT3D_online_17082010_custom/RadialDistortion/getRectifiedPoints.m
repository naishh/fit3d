% getRectifiedPoints - Account for radial distortion in the given set
% of points
%
%
% Given the radial distortion parameters based on Zisserman´s model (p.135)
% and the center of distortion (typically the center of the image) it 
% corrects the given set of points.
%
%
% Input  - K    -> kx1   Radial distortion parameters.
%        - Xc   -> 2x1   Center of radial distortion
%        - X    -> mx2   Image coordinate points
%
% Output - Xr   -> mx2   Corrected points
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function Xr = getRectifiedPoints(K, Xc, X)


% Obtain the distortion rs
r2 = (X(:,1)-Xc(1)).^2+(X(:,2)-Xc(2)).^2;
r1 = sqrt(r2);
r3 = r1.^3;
r4 = r1.^4;
r5 = r1.^5;
r6 = r1.^6;
r7 = r1.^7;



% Compnesate for distortion
if(length(K)==7)
    Xr(:,1) = Xc(1)+(1 +K(1).*r1+K(2).*r2+K(3).*r3+K(4).*r4+K(5).*r5+K(6).*r6+K(7).*r7).*(X(:,1)-Xc(1));
    Xr(:,2) = Xc(2)+(1 +K(1).*r1+K(2).*r2+K(3).*r3+K(4).*r4+K(5).*r5+K(6).*r6+K(7).*r7).*(X(:,2)-Xc(2));
elseif(length(K)==6)
    Xr(:,1) = Xc(1)+(1 +K(1).*r1+K(2).*r2+K(3).*r3+K(4).*r4+K(5).*r5+K(6).*r6).*(X(:,1)-Xc(1));
    Xr(:,2) = Xc(2)+(1 +K(1).*r1+K(2).*r2+K(3).*r3+K(4).*r4+K(5).*r5+K(6).*r6).*(X(:,2)-Xc(2));
elseif(length(K)==5)
    Xr(:,1) = Xc(1)+(1 +K(1).*r1+K(2).*r2+K(3).*r3+K(4).*r4+K(5).*r5).*(X(:,1)-Xc(1));
    Xr(:,2) = Xc(2)+(1 +K(1).*r1+K(2).*r2+K(3).*r3+K(4).*r4+K(5).*r5).*(X(:,2)-Xc(2));
elseif(length(K)==4)
    Xr(:,1) = Xc(1)+(1 +K(1).*r1+K(2).*r2+K(3).*r3+K(4).*r4).*(X(:,1)-Xc(1));
    Xr(:,2) = Xc(2)+(1 +K(1).*r1+K(2).*r2+K(3).*r3+K(4).*r4).*(X(:,2)-Xc(2));
elseif(length(K)==3)
    Xr(:,1) = Xc(1)+(1 +K(1).*r1+K(2).*r2+K(3).*r3).*(X(:,1)-Xc(1));
    Xr(:,2) = Xc(2)+(1 +K(1).*r1+K(2).*r2+K(3).*r3).*(X(:,2)-Xc(2));  
elseif(length(K)==2)
    Xr(:,1) = Xc(1)+(1 +K(1).*r1+K(2).*r2).*(X(:,1)-Xc(1));
    Xr(:,2) = Xc(2)+(1 +K(1).*r1+K(2).*r2).*(X(:,2)-Xc(2));  
elseif(length(K)==1)
    Xr(:,1) = Xc(1)+(1 +K(1).*r1).*(X(:,1)-Xc(1));
    Xr(:,2) = Xc(2)+(1 +K(1).*r1).*(X(:,2)-Xc(2)); 
else
    Xr = 0;
end;

