function HoughlinesRot = flipHoughlinesRot(HoughlinesRot, imHeight)

for k = 1:length(HoughlinesRot)
	% TODO get xy from Theta(..) above, calc as matrix
	xy = [invertCoordFlipY(HoughlinesRot(k).point1,imHeight); invertCoordFlipY(HoughlinesRot(k).point2,imHeight)];
	% save inverted coord on HoughlinesRot
	HoughlinesRot(k).point1 = xy(1,:); HoughlinesRot(k).point2 = xy(2,:);
end
