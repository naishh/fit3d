% writeOutForPMVS - Export camera poses as txt files to be used in PMVS
%
%
% Input  - Pcam -> (3x4xn) n relative camera poses 
% 	 - K 	-> (3x3xn) n camera calibration matrices
%
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [PcamABS,PcamABSK,PcamR] = writeOutForPMVS(Pcam,Km)

    swap = [1,0,0,0;
            0,1,0,0;
            0,0,1,0;
            0,0,0,1];

    
    % Put in ABS coords
    [a,c,PcamABS] = getTrajectory3DNorm(Pcam(1:3,:,:));
    
    % Multiply by K
    PcamABSK = zeros(4,4,size(PcamABS,3));
    for(i=1:size(Pcam,3))
        if(size(Km,3)==1)
            K = Km;
        else
            K = Km(:,:,i);
        end;
        PcamABSK(:,:,i) = [[K;0,0,0],[0;0;0;1]]*swap*normalizePcam(PcamABS(:,:,i))*swap;
    end;
    
    % Write txt files
    for(i=1:size(Pcam,3))
        
        fileName = [];
        
        num = num2str(i-1);
        
        for(j=1:8-length(num))
            fileName = strcat(fileName,'0');
        end;
        
        fileName = strcat(fileName,num,'.txt');
        
        dlmwrite(fileName,'CONTOUR','');
               
        dlmwrite(fileName,PcamABSK(1:3,:,i),'delimiter',' ','-append');
        
    end;
    
    
    % Write VIS.DAT
    fileName = 'vis.dat';
    f = 'VISDATA';
    dlmwrite(fileName,f,'delimiter','');
    dlmwrite(fileName,size(Pcam,3),'-append');
    
    for(i=0:size(Pcam,3)-1)
        if(i+3<size(Pcam,3))
            a = [i,3,i+1,i+2,i+3];
        else
            a = [i,0];
        end;
        dlmwrite(fileName,a,'delimiter',' ','-append');
    end;
