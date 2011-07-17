function plotProjectionLine(projectionLine,lineType)
%figure(figBuilding);
hold on;
plot3(projectionLine(:,1),projectionLine(:,2),projectionLine(:,3),lineType)
