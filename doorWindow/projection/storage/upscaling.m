if false

% scales up from example -3..1 to 0..1024
%load('XYproj.mat');

Ymin = min(XYproj(:,1))
Xmin = min(XYproj(:,2))
Ymax = max(XYproj(:,1))
Xmax = max(XYproj(:,2))

load('upscaleVars.mat');

% calc intervals and offsets
Xinterval = Xmax-Xmin
Yinterval = Ymax-Ymin
Offset = [-Ymin, -Xmin]
newResolution = [Dataset.ImReader.imHeight, Dataset.ImReader.imWidth]
Multiplier = newResolution ./ [Yinterval,Xinterval]
MultiplierRep = repmat(Multiplier,[length(XYproj),1]);
OffsetRep     = repmat(Offset,[length(XYproj),1]);


% add offset
XYprojScaled = XYproj + OffsetRep;
disp(' should be 0 ');
min(XYprojScaled(:,1))
min(XYprojScaled(:,2))

% do multiplier
XYprojScaled = XYprojScaled .* MultiplierRep

disp(' should be 1000 or so '); 
max(XYprojScaled(:,1))
max(XYprojScaled(:,2))

% add 1 to start at idx 1 (array indexing)
XYprojScaledRound = 1+round(XYprojScaled);

save('upscaleVars.mat','Xmin','Ymin','Xmax','Xmin','Multiplier','Offset')


ImEdgeProj = zeros(newResolution);
for i=1:length(XYprojScaledRound)
	i/length(XYprojScaledRound)*100
	ImEdgeProj(XYprojScaledRound(i,1), XYprojScaledRound(i,2)) = 1;
end
%ImEdgeProj(XYprojScaledRound(:,1), XYprojScaledRound(:,2)) = 1;

%%	ImEdgeProj(round(xyProj(1)), round(xyProj(2))) = 1;
figure;imshow(ImEdgeProj);

end
