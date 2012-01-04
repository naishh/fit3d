function plotCornerHarris(cornerScaleAccu,colorStr);
scale = 1;
X = cornerScaleAccu(scale).CornersProjected(:,1);
Y = cornerScaleAccu(scale).CornersProjected(:,2);
plot(X,Y,colorStr);
