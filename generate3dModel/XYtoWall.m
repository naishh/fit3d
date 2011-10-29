load XY

Z = 10;

nrCorners = length(X)
Walls = zeros(nrCorners-1,12);

for i = 1:nrCorners-1
	i
	Walls(i,:) = [X(i),Y(i),0, X(i+1),Y(i+1),0, X(i),Y(i),Z, X(i+1),Y(i+1),Z];
end

Walls
