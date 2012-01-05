function plotcCorner(cCorner);
%clf; hold on;
% plot original cCorner
lineSpec = 'g-';
plot(cCorner.vlineOri(1,:), -cCorner.vlineOri(2,:), lineSpec, 'LineWidth',5);
lineSpec = 'r-';
plot(cCorner.hlineOri(1,:), -cCorner.hlineOri(2,:), lineSpec, 'LineWidth',5);
axis square;
%pause;


% plot tjoint cCorner
p1 = cCorner.hlineTjointEnd;
p2 = cCorner.vlineTjointEnd;
p3 = cCorner.crossing;
p4 = p1 + (p2-p3);
%X = [p4(1), p2(1), p3(1), p1(1), p4(1)];
%Y = [p4(2), p2(2), p3(2), p1(2), p4(2)];

%if cCorner.harrisEvidence == 1
%	lineSpec = 'r-';
%else
%	lineSpec = 'k--';
%end
lineSpec = 'k--';

% hline
X = [p1(1), p3(1)];
Y = [p1(2), p3(2)];
plot(X,-Y,lineSpec);

%vline
X = [p3(1), p2(1)];
Y = [p3(2), p2(2)];
plot(X,-Y,lineSpec);

%paralellogram 
X = [p2(1), p4(1), p1(1)];
Y = [p2(2), p4(2), p1(2)];
plot(X,-Y,lineSpec);

% black cross at crossing
X = cCorner.crossing(1);
Y = cCorner.crossing(2);
plot(X,-Y,'k+');

% blue cross in middle
X = round((p1(1)+ p3(1))/2);
Y = round((p2(2)+ p3(2))/2);
%X = cCorner.xyWindow(1);
%Y = cCorner.xyWindow(2);
plot(X,-Y,'b+');
axis square;
pause;