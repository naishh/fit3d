function Ccs = getCameraCentersFromP(PcamX)
maxP = length(PcamX);
Ccs = cell(maxP,1)

Ccs{1} = [0;0;0];
for i = 2:maxP
	Ccs{i} = Ccs{i-1} + PcamX(:,4,i)
end
