function Houghlines = getHoughlines(BW, plotme)
%close all;
[H,T,R] = hough(BW);

%P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
thresh = 0.2;
P  = houghpeaks(H,5,'threshold',ceil(thresh*max(H(:))));
figure;
imshow(P)
figure;
x = T(P(:,2)); y = R(P(:,1));
%Houghlines = houghlines(BW,T,R,P,'FillGap',25,'MinLength',40);

%TODO make minimum length depended of the width of the image
Houghlines = houghlines(BW,T,R,P,'FillGap',10,'MinLength',70);
if plotme
   figure,imshow(BW), hold on
end
max_len = 0;
for k = 1:length(Houghlines)
	k
	%pause
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
