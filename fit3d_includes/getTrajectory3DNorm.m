% getTrajectory3DNorm - Obtain the absolute trajectory of a camera given the set of relative camera poses. 
%
% This is achieved by normalizing the camera matrices and chain multiplication.
%
%
% Input  - Pcam   	-> (3x4xn) Relative camera matrices for n poses
%
% Output - PcamABS   	-> (3x4xn) Absolute camera matrices for n poses
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function [PcamABS] = getTrajectory3DNorm(Pcam)

    PcamABS = zeros(4,4,size(Pcam,3));
    
    % Normalize
    PcamN = normalizePcam(Pcam);
    
    PcamABS(:,:,1) = PcamN(:,:,1);
    
    % Accumulate
    for(i=2:size(Pcam,3))
        
        PcamABS(:,:,i) = PcamABS(:,:,i-1)*PcamN(:,:,i);
	
    end;
    
    PcamABS = PcamABS(1:3,:,:);
    
  
