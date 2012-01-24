%% Returns the projection of the 3D points into the plane defined by the
%% normal N and the point in the plane X given the center of projection C

function pts = getProjectionIntoPlane(N,X,C,R3D)
    
    pts = ones(size(R3D,1),size(R3D,2));

    for p=1:size(pts,2)
        u = (dot(N,(X-C)))/(dot(N,(R3D(1:3,p)-C)));
        
        pts(1:3,p) = C+u*(R3D(1:3,p)-C);
    end;