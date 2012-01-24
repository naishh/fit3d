%%%%%%%%%%%%%%%%%%%%%%%%%
%% INSTALLATION SCRIPT %%
%%%%%%%%%%%%%%%%%%%%%%%%%

% Copyright TNO 2010
% Contact: isaac.esteban@tno.nl

% This script will add all the required folders to your path. If you want
% the installation to be permanent, make sure you save your path settings.

% Get current directory
W = what;

% Build recursive path
P = genpath(W.path);

% Add path
path(path,P);

% Set installation path variable. This is used to read and store data for
% the examples
install_path = W.path;

% Setup VL_FEAT (not neccessary if you prefer to use LOWE's SIFT)
vl_setup

fprintf('FIT3D is now ready to work.\n\n');
fprintf('Please note that if you clear the workspace, you might need to re-run FIT3D_setup.\n');
fprintf('You can find all available scripts in the run_examples.m script.\n');
fprintf('ENJOY!\n');
