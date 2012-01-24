%%%%%%%%%%%%%%
%% EXAMPLES %%
%%%%%%%%%%%%%%

% This script will show you how to run the several examples provided in the
% Toolbox. All the examples are scripts that utilize one or more functions
% of the toolbox and they all use datasets provided here. All example
% scripts are provided in the examples folder within each Chapter. The data
% is provided in the folder data for every examples folder.

% Just comment out each script to run it.

%%%%%%%%%%%%%%%%%%%%%%%
%% RADIAL DISTORTION %%
%%%%%%%%%%%%%%%%%%%%%%%

%% Undistort a distorted image by selecting striaght lines in the real
% world.
scriptUndistortImage;

%%%%%%%%%%%%%%%%
%% HOMOGRAPHY %%
%%%%%%%%%%%%%%%%

%% Stitch a panoramic image with an indoor dataset
%scriptStitchPanoIndoor;

%% Stitch a panoramic image with an outdoor dataset
%scriptStitchPanoOutdoor;

%%%%%%%%%%%%%%%%%%%%%%%
%% MOTION ESTIMATION %%
%%%%%%%%%%%%%%%%%%%%%%%

%% Compute camera motion on an outdoor dataset
%scriptComputeCameraMotion;

%%%%%%%%%%%%%%%%%%%%%%
%% SCALE ADJUSTMENT %%
%%%%%%%%%%%%%%%%%%%%%%

%% Compute the scale using our 1-point algorithm in Least Square form and
%% build a 3D map.
%scriptComputeScaleLinearly;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RECONSTRUCTION AND MODELING %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Compute the 3D model and extract planar features
%scriptGetFull3DModel;