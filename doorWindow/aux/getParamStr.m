function paramStr = getParamStr(Dataset)
paramStr = ['src_',Dataset.fileShort,'_colorModel_',Dataset.colorModel,'__Dataset.EdgeDetectorParams_',Dataset.EdgeDetectorParam.type,'_thresh_',num2str(Dataset.EdgeDetectorParam.thresh),'__Dataset.HoughParams_', 'thresh_',num2str(Dataset.HoughParam.thresh) , '_nrPeaks_',num2str(Dataset.HoughParam.nrPeaks) , '_fillGap_',num2str(Dataset.HoughParam.fillGap) , '_minLength_',num2str(Dataset.HoughParam.minLength),'__ThetaRangeH_',num2str(Dataset.HoughParam.ThetaH.Start),':',num2str(Dataset.HoughParam.ThetaH.Resolution),':',num2str(Dataset.HoughParam.ThetaH.End),'_ThetaRangeV_',num2str(Dataset.HoughParam.ThetaV.Start),':',num2str(Dataset.HoughParam.ThetaV.Resolution),':',num2str(Dataset.HoughParam.ThetaV.End),'.png'];
