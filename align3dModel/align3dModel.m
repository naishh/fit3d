close all;

% give isaac the coords
load ReconstructionModelingOutputvars
% plot3(MAP(:,1),MAP(:,2),MAP(:,3),'r.')

% plot small dots and project on ground plane by leaving Y value 0
plot(MAP(:,1),MAP(:,3),'r.','MarkerSize',1)
hold on

plot(-1.7310, 7.2957,'g.');
plot(-8.6977, 11.9792,'g.');

