function plotcCorner(i,k,Houghlines, HoughlinesRot, colorStr1)

cCorner = Houghlines(i).cCorners(k);
idx = cCorner.HoughlineRotIdx;
%plotHoughlineShort(HoughlinesRot(idx),1, colorStr1);

plot(cCorner.crossing(1), -cCorner.crossing(2),'k+');
