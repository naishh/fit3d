% calcLineSubCoords calculates 3 subcoords of a line
% given two coords:
% +-----------+
% it calculates the in between coords
% +--+--+--+--+
% using the midrule (averiging points)

function subCoords = calcLineSubCoords(Houghline, resolution)
%close all; figure; hold on;

p1 = Houghline.point1;
%plotVect = p1; plot3(plotVect(1), plotVect(2), plotVect(3), 'r+')
p2 = Houghline.point2;
%plotVect = p2; plot3(plotVect(1), plotVect(2), plotVect(3), 'r+')

if resolution == 5
	pMid = (p1+p2)/2;
	%plotVect = midPoint; plot3(plotVect(1), plotVect(2), plotVect(3), 'b+')
	pLeft = (p1+pMid)/2;
	%plotVect = pLeft; plot3(plotVect(1), plotVect(2), plotVect(3), 'g+')
	pRight = (p2+pMid)/2;
	%plotVect = pRight; plot3(plotVect(1), plotVect(2), plotVect(3), 'g+')

	subCoords = {p1, pLeft, pMid, pRight, p2};
elseif resolution == 7
	% note this is not linear, the points are more dense at the midpoint
	pMid = (p1+p2)/2;
	%plotVect = midPoint; plot3(plotVect(1), plotVect(2), plotVect(3), 'b+')
	pLeft = (p1+pMid)/2;
	pLeftMid = (pLeft+pMid)/2;
	%plotVect = pLeft; plot3(plotVect(1), plotVect(2), plotVect(3), 'g+')
	pRight = (p2+pMid)/2;
	pRightMid = (pRight+pMid)/2;
	%plotVect = pRight; plot3(plotVect(1), plotVect(2), plotVect(3), 'g+')

	subCoords = {p1, pLeft, pLeftMid, pMid, pRightMid, pRight, p2};
end
