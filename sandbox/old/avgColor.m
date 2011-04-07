function imSkyRGB = avgColor(imRGB, X, Y)
	nrSamples = length(X);
	[h,w,c] = size(imRGB);

	%todo beter datastructure
	imSkyR = uint32(0); imSkyG = uint32(0); imSkyB = uint32(0);
	% sum colors
	for i=1:nrSamples
		imSkyR = imSkyR + uint32(imRGB(Y(i),X(i),1));
		imSkyG = imSkyG + uint32(imRGB(Y(i),X(i),2));
		imSkyB = imSkyB + uint32(imRGB(Y(i),X(i),3));
	end

	imSky = [imSkyR, imSkyG, imSkyB];
	imSky = imSky / nrSamples;


	imSkyRGB = uint8(zeros(h,w,c));

	imSkyRGB(:,:,1) = imSky(1);
	imSkyRGB(:,:,2) = imSky(2);
	imSkyRGB(:,:,3) = imSky(3);

	figure;
	imshow(imSkyRGB);
