function Houghlines = getHoughlines(BW, plotme)
%close all;
[H,T,R] = hough(BW);

P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
Houghlines = houghlines(BW,T,R,P,'FillGap',25,'MinLength',40);
if plotme
   figure,imshow(BW), hold on
end
max_len = 0;
for k = 1:length(Houghlines)
	k
	pause
   xy = [Houghlines(k).point1; Houghlines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of Houghlines
if plotme
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end

   % Determine the endpoints of the longest line segment
   len = norm(Houghlines(k).point1 - Houghlines(k).point2);
   if ( len > max_len)
	  max_len = len;
	  xy_long = xy;
   end
end

% highlight the longest line segment
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
