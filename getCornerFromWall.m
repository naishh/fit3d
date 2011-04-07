% gets a WALLcorner from the WALL matrix 
function corner = getCornerFromWall(WALLS,idx)
h = idx(1)
w = idx(2)

w2 = (w-1)*3+1
corner = WALLS(h,w2:w2+2)
