%ideas, something with blue channel and contrast

% er zijn als het goed is 2 clusters en met variantie kan iets gedaan worden zie paper vision guided..


%close all;
%thresh = 0.5;
thresh = 0.1;
%imRGB = imread('dataset/img02.jpg');
%imRGB = imread('dataset/img03_AKBuilding.jpg');
imRGB = imread('dataset/img04_house.jpg');
imRGBoriginal = imRGB;
%todo
%imRGB = normalizeRGB(imRGB)
[h,w,c] = size(imRGB);
imGray = rgb2gray(imRGB);

close all;
figure(1);
imshow(imRGB);


nrSamples = 3;
print('select 3 pixels of the sky');
if ~(exist('X') && exist('Y'))
	[X,Y] = ginput(nrSamples)
end
X = round(X); Y = round(Y)
imSkyRGB = avgColor(imRGB, X, Y);

figure(1);
print('now three of the building');
if ~(exist('U') && exist('V'))
	[U,V] = ginput(nrSamples)
end
U = round(U); V = round(V)
imGroundRGB = avgColor(imRGB, U, V);


imRGB = single(imRGB);
imSky = single(imSky);
imSkyRGB = single(imSkyRGB);
imGround = single(imGround);
imGroundRGB = single(imGroundRGB);

imSkyEuclid = zeros(h,w);
for i=1:h
	for j=1:w
		rDiff = (imRGB(i,j,1)-imSky(1))^2;
		gDiff = (imRGB(i,j,1)-imSky(2))^2;
		bDiff = (imRGB(i,j,1)-imSky(3))^2;
		euclid = rDiff + gDiff + bDiff;
		imSkyEuclid(i,j) = euclid;
	end
end

%figure; imshow(imSkyEuclid,[])

imGroundEuclid = zeros(h,w);
for i=1:h
	for j=1:w
		rDiff = (imRGB(i,j,1)-imGround(1))^2;
		gDiff = (imRGB(i,j,1)-imGround(2))^2;
		bDiff = (imRGB(i,j,1)-imGround(3))^2;
		euclid = rDiff + gDiff + bDiff;
		imGroundEuclid(i,j) = euclid;
	end
end

%figure; imshow(imGroundEuclid,[])


%S = zeros(size(imSkyEuclid))
%S(imSkyEuclid > imGroundEuclid) = 1;
%figure;
%imshow(S);


imSkyEuclid = rescale(imSkyEuclid);

imGray = imSkyEuclid;

imEdge = edge(imGray, 'sobel', thresh);
%imEdge = imread('img02_floriande_edge.jpg');

figure;imshow(imEdge,[]); pause;

se = strel('disk',10)
imEdgeClosed = imopen(imEdge, se);
figure;imshow(imEdgeClosed);pause;

[H,T,R] = hough(imEdge);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

% Find lines and plot them
lines = houghlines(imEdge,T,R,P,'FillGap',2,'MinLength',7);
figure, imshow(imRGBoriginal), hold on
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


