function plotHoughline(Houghlines, imNr, i);
% plot houghline
xy = [Houghlines{imNr}(i).point1; Houghlines{imNr}(i).point2];
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

% Plot beginnings and ends of Houghlines
plot(xy(1,1),xy(1,2),'+','LineWidth',2,'Color','black');
plot(xy(2,1),xy(2,2),'+','LineWidth',2,'Color','blue');
