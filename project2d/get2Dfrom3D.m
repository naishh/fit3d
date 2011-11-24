% returns the coord in 2d 
function xy = get2Dfrom3D(xy3D, imNr, PcamAbs, K)

R = PcamAbs(:,1:3,imNr);
T = PcamAbs(:,4,imNr);

%xy3D = R*inv(K)*xyH+T;

%xyH = inv(R) * K * (xy3D - T) 
xyH = K * inv(R) * (xy3D - T);


%remove homogenity 
xy = xyH/xyH(3);
xy = [xy(1), xy(2)];

