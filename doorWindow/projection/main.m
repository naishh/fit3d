% run setup first
cd ../..;setup;cd doorWindow/projection

Dataset = getDataset('Spil4BigOutline',startPath)
%Dataset = getDataset('Floriande0',startPath)
%Dataset = getDataset('Floriande0Outline',startPath)
%figure; imshow(Dataset.ImReader.imColorModelTransform)
