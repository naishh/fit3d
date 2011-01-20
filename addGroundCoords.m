% adds ground coords (bottom coords of walls) to beginning and end
function ispsPerWall2 = addGroundCoords(WALLS, ispsPerWall)
[h, w] = size(ispsPerWall);

ispsPerWall2 = cell(h, w+2);

for wall=1:size(ispsPerWall,1)
	coord = getCornerFromWall(WALLS,[wall,2]);
	% add coord to the beginning of the cell array
	ispsPerWall2{wall,1} = coord;
	% copy middle coords
	ispsPerWall2(wall,2:w+1) = ispsPerWall(wall,:);
	coord = getCornerFromWall(WALLS,[wall,1]);
	% add coord to the end of the cell array
	ispsPerWall2{wall,w+2} = coord;
end

