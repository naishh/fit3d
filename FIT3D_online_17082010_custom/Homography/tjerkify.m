close all;
if exist('install_path') == 0
	disp('setup not initialized, press a key to run setup?');
	pause;
	cd ..
	FIT3D_setup
	cd Homography
end

Im = imread('/media/Storage/scriptie/fit3d/dataset/Spil/datasetSpilRect/P_rect4.jpg');
imshow(Im)
hold on;

load('rectifyInfo_PC_Spil_P_rect4.mat');
%[X,Y] = ginput(4);
%[X2,Y2] = ginput(4);

A = [X';Y';ones(1,length(X))];
B = [X2';Y2';ones(1,length(Y))];

A
B
H = goldStd2D(A,B)



% from skew to straight
for i=1:4
	v = [X(i); Y(i); 1];
	plot(v(1), v(2),'r+','MarkerSize',15, 'LineWidth',5);
	hold on;
	w = inv(H)*v; w=w/w(3)
	plot(w(1), w(2),'b+','MarkerSize',15,'LineWidth',5);
	
end

if false
while(true)
	[x,y] = ginput(1)
	v = [x; y; 1];
	plot(v(1), v(2),'r+','MarkerSize',15, 'LineWidth',5);
	w = inv(H)*v; w=w/w(3)
	plot(w(1), w(2),'b+','MarkerSize',15,'LineWidth',5);
end
end


% H transform from straight to skew
% we need inv(H) transforms from skew to straight
save('rectifyInfo_H_Spil_rect4.mat','H');
