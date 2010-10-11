%ideas, something with blue channel and contrast

% er zijn als het goed is 2 clusters en met variantie kan iets gedaan worden zie paper vision guided..


%close all;
%thresh = 0.5;
thresh = 0.1;
%imRGB = imread('img02_floriande_highcontrast.jpg');
%imGray = imread('img02_floriande_highcontrast.jpg');
imRGB = imread('img02.jpg');
imGray = rgb2gray(imRGB);

close all;
figure;
imshow(imRGB);

nrSamples = 3;
%[X,Y] = ginput(nrSamples)

%todo beter datastructure
imSkyR = uint32(0);
imSkyG = uint32(0);
imSkyB = uint32(0);
for i=1:nrSamples
	imSkyR = imSkyR + uint32(imRGB(Y(i),X(i),1));
	imSkyG = imSkyG + uint32(imRGB(Y(i),X(i),2));
	imSkyB = imSkyB + uint32(imRGB(Y(i),X(i),3));
end

imSky = [imSkyR, imSkyG, imSkyB]
imSky = imSky / nrSamples

[w,h,c] = size(imRGB)

imSkyRGB = uint8(zeros(w,h,c));

imSkyRGB(:,:,1) = imSky(1);
imSkyRGB(:,:,2) = imSky(2);
imSkyRGB(:,:,3) = imSky(3);
figure;
imshow(imSkyRGB);

err
figure
imshow(imRGB - imSky)

err
% [h,w] = size(imGray)
% imVar = zeros(h,w);
% 
% squareSize = 3
% for i=1:h
% 	for j=1:w
% 
% 		imVar(i,j) = 
% 
% 	end
% end

imEdge = edge(imGray, 'sobel', thresh);
%imEdge = imread('img02_floriande_edge.jpg');

%imshow(imEdge,[]); pause;

[H,T,R] = hough(imEdge);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

% Find lines and plot them
lines = houghlines(imEdge,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(imRGB), hold on
%figure, imshow(imEdge), hold on

max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');


