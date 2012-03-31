function plotHistY(X,Y, colorStr)
for i=1:length(X)
	x = X(i);
	y = Y(i);
	plot([0,x], [y,y], colorStr)
end

