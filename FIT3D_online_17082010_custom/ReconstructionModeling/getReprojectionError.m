% getReprojectionError - Compute reprojection error 
%
%
% Given two set of corresponding points in image 1 and 2, the reprojection
% error is computed (the distance between the original and calculated
% points). This is the cost function defined by Zisserman in page p.314
%
%
% Input  - X1X2opt   -> 4xn set of homogeneous points in image 1 and 2
%        - X1X2or    -> 6xn set of homogeneous points in image 2 and 2
%                       (this are the reprojected points)
%
% Output - e         -> 1xn error in distance measure
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010


function e = getReprojectionError(X1X2opt,X1X2or)

  

  % Original points
  X1or = X1X2or(:,1:3);
  X2or = X1X2or(:,4:6);
  
  % Optimized feature points
  X1opt = [X1X2opt(:,1:2),ones(size(X1X2or,1),1)];
  X2opt = [X1X2opt(:,3:4),ones(size(X1X2or,1),1)];
  

  
  %figure(1), clf(1),plot(X1or(:,1),X1or(:,2),'ro'),hold on, plot(X1opt(:,1),X1opt(:,2),'bx'), axis([0 250 0 250]),drawnow;
  
  % Sum of distances
  e = sum(sqrt(sum((X1opt-X1or).^2,1)+sum((X2opt-X2or).^2,1)));
