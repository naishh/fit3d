houghEndpointsFileName 	= 'hough-endpoints.obj';
houghLinesFileName     	= 'hough-lines.obj';

load 					'imBWSkyline1.mat';
lines 					= houghlinesMain(imBWSkyline)

% loop through found houghlines endpoints and project to 3D
for i=1:length(lines)
	HoughLineEndpoint1 = get2Dfrom3D(lines(i).point1);
	HoughLineEndpoint2  = get2Dfrom3D(lines(i).point2);
	writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint1, 0.1);
	writeObjCube(houghEndpointsFileName, 1, HoughLineEndpoint2, 0.1);
	writeObjLine(houghLinesFileName, HoughLineEndpoint1,HoughLineEndpoint2,'red');
end
