function wallNormal = getNormalFromWall(Walls, wallNr)
% corner points wall
% p2    p1
% -------
% |     |
% -------
% p4    p3


% select data
p2 = Walls(wallNr,4:6) 
p3 = Walls(wallNr,7:9) 
p4 = Walls(wallNr,10:12) 

% calc relative vectors with corner p4 as origin
v = p3-p4
w = p2-p4

% cross product
wallNormal = cross(v,w)

% normalize
wallNormal = wallNormal/norm(wallNormal)

