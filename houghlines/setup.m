startPaths = {'C:/Temp/tkosteli/fit3d/','/mnt/linuxoldDocs/documents/studie/scriptie/git/','E:/fit3d/'}

for i=1:length(startPaths)
	path(path,startPaths{i});
	path(path,[startPaths{i}, 'fit3d_includes']);
	path(path,[startPaths{i}, 'mats']);
end
