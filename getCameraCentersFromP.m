function Ccs = getCameraCentersFromP(PcamX)
% clear file
fp = fopen('ccs.obj', 'w'); fprintf(fp,'mtllib colors.mtl\n'); fclose(fp);

maxP = length(PcamX);
Ccs = cell(maxP,1)

Ccs{1} = [0;0;0];

for i = 2:maxP
	R = PcamX(:,1:3,i);
	T = PcamX(:,4,i);
	%Ccs{i} = Ccs{i-1} + R*(-T)
	Ccs{i} = Ccs{i-1} - R*(T)
end

writeObjCube('ccs.obj', 1, Ccs{1}, 0.05);
writeObjCube('ccs.obj', 1, Ccs{2}, 0.05);
writeObjCube('ccs.obj', 1, Ccs{3}, 0.05);
writeObjCube('ccs.obj', 1, Ccs{4}, 0.05);
writeObjCube('ccs.obj', 1, Ccs{5}, 0.05);
