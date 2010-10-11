%ideas, something with blue channel and contrast

% er zijn als het goed is 2 clusters en met variantie kan iets gedaan worden zie paper vision guided..


%close all;
%thresh = 0.5;
thresh = 0.1;
%imRGB = imread('dataset/img02.jpg');
imRGB = imread('dataset/img03_AKBuilding.jpg');
%todo
%imRGB = normalizeRGB(imRGB)
imGray = rgb2gray(imRGB);

close all;
figure;
imshow(imRGB);


nrSamples = 3;
print('select 3 pixels of the sky');
[X,Y] = ginput(nrSamples)

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

[h,w,c] = size(imRGB)

imSkyRGB = uint8(zeros(w,h,c));

imSkyRGB(:,:,1) = imSky(1);
imSkyRGB(:,:,2) = imSky(2);
imSkyRGB(:,:,3) = imSky(3);


% -------------- GROUND -----------------------------------
print('now the building');
[U,V] = ginput(nrSamples)
%todo beter datastructure
imGroundR = uint32(0);
imGroundG = uint32(0);
imGroundB = uint32(0);
for i=1:nrSamples
	imGroundR = imGroundR + uint32(imRGB(V(i),U(i),1));
	imGroundG = imGroundG + uint32(imRGB(V(i),U(i),2));
	imGroundB = imGroundB + uint32(imRGB(V(i),U(i),3));
end

imGround = [imGroundR, imGroundG, imGroundB]
imGround = imGround / nrSamples

imGroundRGB = single(zeros(h,w,c));

imGroundRGB(:,:,1) = imGround(1);
imGroundRGB(:,:,2) = imGround(2);
imGroundRGB(:,:,3) = imGround(3);
%imshow(imGroundRGB);


figure;
imRGB = single(imRGB);
imSkyRGB = single(imSkyRGB);
imGroundRGB = single(imGroundRGB);



imRGB = single(imRGB);
imSky = single(imSky);
imGround = single(imGround);

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

figure;
imshow(imSkyEuclid,[])

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

figure;
imshow(imGroundEuclid,[])

% % lagere S betekent hogere kans dat het Sky is
% S = abs(imRGB - imSkyRGB);
% G = abs(imRGB - imGroundRGB);
% 






err
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


