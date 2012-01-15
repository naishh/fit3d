function plotcCorner(cCorner,plotMode);
hold on;
pause;
% set to -1 if u use projected values 
YnoInvert = 1;
% calc coords of paralelleogram
p1 = cCorner.hlineTjointEnd;
p2 = cCorner.vlineTjointEnd;
p3 = cCorner.crossing;
p4 = p1 + (p2-p3);


%plotMode = 'windowOnly';
plotMode = 'cCorner';

if true
	lineSpec = 'r-';
	lineSpecLineWidth = 1;
	% one hline
	X = [p1(1), p3(1)];
	Y = [p1(2), p3(2)];
	plot(X,YnoInvert*Y,lineSpec,'LineWidth',lineSpecLineWidth);

	% one vline
	X = [p3(1), p2(1)];
	Y = [p3(2), p2(2)];
	plot(X,YnoInvert*Y,lineSpec,'LineWidth',lineSpecLineWidth);

	% two other lines of paralellogram 
	X = [p2(1), p4(1), p1(1)];
	Y = [p2(2), p4(2), p1(2)];
	plot(X,YnoInvert*Y,lineSpec,'LineWidth',lineSpecLineWidth);

end
if true
	% blue cross in middle
	X = cCorner.windowMidpointX;
	Y = cCorner.windowMidpointY;
	plot(X,YnoInvert*Y,'b+','MarkerSize',10);

end
%plotMode == 'cCorner'
if false 

	% plot original cCorner
	%disp('plot original cCorner');
	lineSpec = 'g-';
	plot(cCorner.vlineOri(1,:), YnoInvert*cCorner.vlineOri(2,:), lineSpec, 'LineWidth',5);
	lineSpec = 'r-';
	plot(cCorner.hlineOri(1,:), YnoInvert*cCorner.hlineOri(2,:), lineSpec, 'LineWidth',5);


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
end
