startPath = pwd();
path(path, [startPath,'/Tools']);
cd ..
startPathRoot = pwd();
cd ../FIT3D_online_17082010
FIT3D_setup
cd(startPath)

datasetDir = [startPathRoot, '/dataset/datasetSpil/',datasetName,'/'];
