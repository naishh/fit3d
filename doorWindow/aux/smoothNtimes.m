function im = smoothNtimes(im,n)
for i=1:n
	im = smooth(im);
end
