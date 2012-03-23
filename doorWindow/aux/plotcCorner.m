function plotcCorner(cCorner,plotMode,pauseMode);

hold on;
if pauseMode
	pause;
end


% set to -1 if u use projected values 
YnoInvert = 1;
% calc coords of paralelleogram
p1 = cCorner.hlineTjointEnd;
p2 = cCorner.vlineTjointEnd;
p3 = cCorner.crossing;
p4 = p1 + (p2-p3);


%plotMode = 'windowOnly';
%plotMode = 'cCorner';

if strcmp(plotMode, 'window')
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

	% blue cross in middle
	X = cCorner.windowMidpointX;
	Y = cCorner.windowMidpointY;
	plot(X,YnoInvert*Y,'b+','MarkerSize',10);

elseif strcmp(plotMode, 'windowFilled')
	lineSpec = 'r-';
	lineSpecLineWidth = 1;

	% one hline
	X = [p1(1), p3(1), p2(1), p4(1), p1(1)];
	Y = [p1(2), p3(2), p2(2), p4(2), p1(2)];
	Y = YnoInvert*Y;
	fill(X,Y,'r', 'EdgeColor','r');

elseif strcmp(plotMode, 'cCornerBlack')
		
	lineSpec = 'k-';
	plot(cCorner.vlineOri(1,:), YnoInvert*cCorner.vlineOri(2,:), lineSpec, 'LineWidth',5);
	plot(cCorner.hlineOri(1,:), YnoInvert*cCorner.hlineOri(2,:), lineSpec, 'LineWidth',5);

elseif strcmp(plotMode, 'cCorner')
		
	drawcCorner = true;
	if isfield(cCorner,'bIncluded')==1 
		if cCorner.bIncluded == true
			drawcCorner  = false;
		end
	end
	if drawcCorner

		% plot original cCorner
		%disp('plot original cCorner');
		lineSpec = 'g-';
		plot(cCorner.vlineOri(1,:), YnoInvert*cCorner.vlineOri(2,:), lineSpec, 'LineWidth',3);
		lineSpec = 'r-';

		plot(cCorner.hlineOri(1,:), YnoInvert*cCorner.hlineOri(2,:), lineSpec, 'LineWidth',3);

		%lineSpec = 'k--';

		%% one hline
		%X = [p1(1), p3(1)];
		%Y = [p1(2), p3(2)];
		%plot(X,YnoInvert*Y,lineSpec);

		%% one vline
		%X = [p3(1), p2(1)];
		%Y = [p3(2), p2(2)];
		%plot(X,YnoInvert*Y,lineSpec);

		%	% two other lines of paralellogram 
		%	X = [p2(1), p4(1), p1(1)];
		%	Y = [p2(2), p4(2), p1(2)];
		%	plot(X,YnoInvert*Y,lineSpec);

		%	% black cross at crossing
		%	X = cCorner.crossing(1);
		%	Y = cCorner.crossing(2);
		%	plot(X,YnoInvert*Y,'k+','MarkerSize',10,'LineWidth',2);

		%	% blue cross in middle
		%	X = cCorner.windowMidpointX;
		%	Y = cCorner.windowMidpointY;
		%	plot(X,YnoInvert*Y,'b+','MarkerSize',10);
	end
elseif strcmp(plotMode, 'cCornerConnectivity')
	if pauseMode
		clf;hold on;
	end

	% drawo ori line
	lineSpec = 'g-';
	plot(cCorner.vlineOri(1,:), YnoInvert*cCorner.vlineOri(2,:), lineSpec, 'LineWidth',3);
	lineSpec = 'r-';
	plot(cCorner.hlineOri(1,:), YnoInvert*cCorner.hlineOri(2,:), lineSpec, 'LineWidth',3);


	% draw dotted line to cross
	hlineTjointEndOposite = getRestMatrix(cCorner.hlineTjointEnd,cCorner.hlineOri); 
	vlineTjointEndOposite = getRestMatrix(cCorner.vlineTjointEnd,cCorner.vlineOri); 
	X = [hlineTjointEndOposite(1),cCorner.crossing(1)];
	Y = [hlineTjointEndOposite(2),cCorner.crossing(2)];
	plot(X,Y,'--k');
	X = [vlineTjointEndOposite(1),cCorner.crossing(1)];
	Y = [vlineTjointEndOposite(2),cCorner.crossing(2)];
	plot(X,Y,'--k');

	% black cross at crossing
	X = cCorner.crossing(1);
	Y = cCorner.crossing(2);
	plot(X,YnoInvert*Y,'k+','MarkerSize',10,'LineWidth',2);

elseif strcmp(plotMode, 'cCornerCutoff')

	lineSpec = 'g-';
	% one hline
	X = [p1(1), p3(1)];
	Y = [p1(2), p3(2)];
	plot(X,YnoInvert*Y,lineSpec,'LineWidth',3);

	lineSpec = 'r-';
	% one vline
	X = [p3(1), p2(1)];
	Y = [p3(2), p2(2)];
	plot(X,YnoInvert*Y,lineSpec,'LineWidth',3);

	% black cross at crossing
	X = cCorner.crossing(1);
	Y = cCorner.crossing(2);
	plot(X,YnoInvert*Y,'k+','MarkerSize',10,'LineWidth',2);

	% blue cross in middle
	X = cCorner.windowMidpointX;
	Y = cCorner.windowMidpointY;
	plot(X,YnoInvert*Y,'b+','MarkerSize',10);

else
	plotMode
	error('tj:invalid plotmode')
end
