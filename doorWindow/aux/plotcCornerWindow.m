function plotcCornerWindow(cCorner);
p1 = cCorner.hlineEnd;
p2 = cCorner.vlineEnd;
p3 = cCorner.crossing;
p4 = p1 + (p2-p3);
X = [p4(1), p2(1), p3(1), p1(1), p4(1)];
Y = [p4(2), p2(2), p3(2), p1(2), p4(2)];
plot(X,-Y,'k-');
