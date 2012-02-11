function HoughResult = rectifyHoughlines(HoughResult, H)
load('rectifyInfo_H_Spil_rect4.mat')
H
% declare memory
HoughResult.HoughlinesRect = HoughResult.Houghlines;
HoughResult.HoughlinesRotRect = HoughResult.HoughlinesRot;

for i=1:length(HoughResult.Houghlines)
	p1 = [HoughResult.Houghlines(i).point1,1]'
	p2 = [HoughResult.Houghlines(i).point2,1]'
	HoughResult.HoughlinesRect(i).point1 = [inv(H)*p1]'
	HoughResult.HoughlinesRect(i).point2 = [inv(H)*p2]'
end

for i=1:length(HoughResult.HoughlinesRot)
	p1 = [HoughResult.HoughlinesRot(i).point1,1]'
	p2 = [HoughResult.HoughlinesRot(i).point2,1]'
	HoughResult.HoughlinesRotRect(i).point1 = [inv(H)*p1]'
	HoughResult.HoughlinesRotRect(i).point2 = [inv(H)*p2]'
end
