function plotcCorner(cCorner);
p1 = cCorner.hlineEnd;
p2 = cCorner.vlineEnd;
p3 = cCorner.crossing;
p4 = p1 + (p2-p3);
%X = [p4(1), p2(1), p3(1), p1(1), p4(1)];
%Y = [p4(2), p2(2), p3(2), p1(2), p4(2)];

% hline
X = [p1(1), p3(1)];
Y = [p1(2), p3(2)];
plot(X,-Y,'r');

%vline
X = [p3(1), p2(1)];
Y = [p3(2), p2(2)];
plot(X,-Y,'g');

%paralellogram 
X = [p2(1), p4(1), p1(1)];
Y = [p2(2), p4(2), p1(2)];
plot(X,-Y,'k--');

% black cross at crossing
X = cCorner.crossing(1);
Y = cCorner.crossing(2);
plot(X,-Y,'k+');

% blue cross in middle
X = cCorner.xyWindow(1);
Y = cCorner.xyWindow(2);
plot(X,-Y,'b+');
