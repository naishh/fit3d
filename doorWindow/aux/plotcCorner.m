function plotcCorner(cCorner);
hold on;

% set to -1 if u use projected values 
YnoInvert = 1;

% plot original cCorner
disp('plot original cCorner');
lineSpec = 'g-';
plot(cCorner.vlineOri(1,:), YnoInvert*cCorner.vlineOri(2,:), lineSpec, 'LineWidth',5);
lineSpec = 'r-';
plot(cCorner.hlineOri(1,:), YnoInvert*cCorner.hlineOri(2,:), lineSpec, 'LineWidth',5);

pause;
% calc coords of paralelleogram
p1 = cCorner.hlineTjointEnd;
p2 = cCorner.vlineTjointEnd;
p3 = cCorner.crossing;
p4 = p1 + (p2-p3);

%if cCorner.harrisEvidence == 1
%	lineSpec = 'r-';
%else
%	lineSpec = 'k--';
%end
lineSpec = 'k--';

% one hline
X = [p1(1), p3(1)];
Y = [p1(2), p3(2)];
plot(X,YnoInvert*Y,lineSpec);

% one vline
X = [p3(1), p2(1)];
Y = [p3(2), p2(2)];
plot(X,YnoInvert*Y,lineSpec);

% two other lines of paralellogram 
X = [p2(1), p4(1), p1(1)];
Y = [p2(2), p4(2), p1(2)];
plot(X,YnoInvert*Y,lineSpec);

% black cross at crossing
X = cCorner.crossing(1);
Y = cCorner.crossing(2);
plot(X,YnoInvert*Y,'k+');

% blue cross in middle
X = round((p1(1)+ p3(1))/2);
Y = round((p2(2)+ p3(2))/2);
plot(X,YnoInvert*Y,'b+');
