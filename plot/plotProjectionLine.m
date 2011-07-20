function plotProjectionLine(projectionLine,lineType)
%figure(figBuilding);
hold on;
plot3([projectionLine(1,1), projectionLine(2,1)],[projectionLine(1,2),projectionLine(2,2)],[projectionLine(1,3),projectionLine(2,3)],lineType)
