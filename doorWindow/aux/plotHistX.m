function plotHistX(imHeight,X,Y)
for i=1:length(X)
	x = X(i);
	y = Y(i);
	plot([x,x], [imHeight,imHeight-y], 'y-')
end

