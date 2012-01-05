% calculates intersection and checks for parallel lines.  
% returns adjusted line segments

% TODO return 2 cCorners if ua or ub <1
function [isp,line1,line2] = findLineIntersection(p1,p2,p3,p4) 
% calculate differences  
xD1=p2(1)-p1(1);  
xD2=p4(1)-p3(1);  
yD1=p2(2)-p1(2);  
yD2=p4(2)-p3(2);  
xD3=p1(1)-p3(1);  
yD3=p1(2)-p3(2);    

% calculate the lengths of the two lines  
len1=sqrt(xD1*xD1+yD1*yD1);
len2=sqrt(xD2*xD2+yD2*yD2); 

% calculate angle between the two lines.  
dot=(xD1*xD2+yD1*yD2); % dot product  
deg=dot/(len1*len2);  

% if abs(angle)==1 then the lines are parallell,  
% so no intersection is possible  
if(abs(deg)==1)
	error('lines are parallel');
end

% find intersection Pt between two lines  
div=yD2*xD1-xD2*yD1;  
ua=(xD2*yD3-yD2*xD3)/div  
ub=(xD1*yD3-yD1*xD3)/div  
% calc intersection point:
isp(1)=p1(1)+ua*xD1;  
isp(2)=p1(2)+ua*yD1; 

% ua and ub are in [0..1] if isp lies on the line ua or ub
if (ub>=0 && ub<=1) && (ua>=0 && ua <=1)
	$disp('point lies on both segments');
	line1 = [p1',p2'];
	line2 = [p3',p4'];
	dist = 0;
else
	p1ispDist = euclideanDist(isp,p1);
	p2ispDist = euclideanDist(isp,p2);
	p3ispDist = euclideanDist(isp,p3);
	p4ispDist = euclideanDist(isp,p4);
	if (ua>=0 && ua <=1)
		disp('point lies on segment 1');
		% p3 is closest to isp
		if p3ispDist<p4ispDist
			dist = p3ispDist
			% make line from oposite of p3 (p4) to isp
			line1 = [p1',p2'];
			line2 = [p4',isp'];
		else
			dist = p4ispDist
			line1 = [p1',p2'];
			line2 = [p3',isp'];
		end
	end
	if (ub>=0 && ub<=1)
		disp('point lies on segment 2');
		% p1 is closest to isp
		if p1ispDist<p2ispDist
			dist = p1ispDist
			% make line from oposite of p1 (p2) to isp
			line1 = [p3',p4'];
			line2 = [p2',isp'];
		else
			dist = p2ispDist
			line1 = [p3',p4'];
			line2 = [p1',isp'];
		end
	end
	if ~(ub>=0 && ub<=1) && ~(ua>=0 && ua <=1)
		disp('point lies outside both segments');
		% add dists of both closest line segment endpoints to isp
		dist = min(p1ispDist,p2ispDist) + min(p3ispDist,p4ispDist);
	end
end

%% calculate the combined length of the two segments  
%% between Pt-p1 and Pt-p2  
%xD1=isp(1)-p1(1);  
%xD2=isp(1)-p2(1);  
%yD1=isp(2)-p1(2);  
%yD2=isp(2)-p2(2);  
%segmentLen1=sqrt(xD1*xD1+yD1*yD1)+sqrt(xD2*xD2+yD2*yD2)
%
%% calculate the combined length of the two segments  
%% between Pt-p3 and Pt-p4  
%xD1=isp(1)-p3(1);  
%xD2=isp(1)-p4(1);  
%yD1=isp(2)-p3(2);  
%yD2=isp(2)-p4(2);  
%segmentLen2=sqrt(xD1*xD1+yD1*yD1)+sqrt(xD2*xD2+yD2*yD2)
%
%% if the lengths of both sets of segments are the same as  
%% the lenghts of the two lines the point is actually  
%% on the line segment.  
%
%% if the point isn’t on the line, return null  
%if(abs(len1-segmentLen1)>0.01 || abs(len2-segmentLen2)>0.01)  
%	error('point not on line');
%end

