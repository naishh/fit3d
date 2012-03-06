% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3375.266452407510769 ; 3361.109141210540656 ];

%-- Principal point:
cc = [ 1582.234850493018712 ; 1302.255666402479847 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.172930910480159 ; 0.413801098901228 ; 0.017883295762067 ; -0.005114095801060 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 34.545688000274303 ; 35.189998012592284 ];

%-- Principal point uncertainty:
cc_error = [ 45.696220086494115 ; 45.550593434053255 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.062974744075514 ; 0.357532767498329 ; 0.003703459582671 ; 0.003550033134558 ; 0.000000000000000 ];

%-- Image size:
nx = 3264;
ny = 2448;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 17;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.234120e+00 ; -2.203246e+00 ; -1.127562e-02 ];
Tc_1  = [ 5.832281e-01 ; 5.534875e-01 ; 2.200582e+00 ];
omc_error_1 = [ 1.326563e-02 ; 1.323796e-02 ; 2.809928e-02 ];
Tc_error_1  = [ 3.039774e-02 ; 3.044880e-02 ; 2.640654e-02 ];

%-- Image #2:
omc_2 = [ 2.004701e+00 ; -2.050806e+00 ; -2.868879e-01 ];
Tc_2  = [ 6.110824e-01 ; 5.161857e-01 ; 2.014486e+00 ];
omc_error_2 = [ 1.278905e-02 ; 1.241916e-02 ; 2.275720e-02 ];
Tc_error_2  = [ 2.806014e-02 ; 2.821803e-02 ; 2.591821e-02 ];

%-- Image #3:
omc_3 = [ 1.878825e+00 ; -1.958886e+00 ; -4.438159e-01 ];
Tc_3  = [ 3.968092e-01 ; 5.255994e-01 ; 1.951497e+00 ];
omc_error_3 = [ 1.317556e-02 ; 1.132941e-02 ; 2.002932e-02 ];
Tc_error_3  = [ 2.686392e-02 ; 2.687667e-02 ; 2.515238e-02 ];

%-- Image #4:
omc_4 = [ 1.781696e+00 ; -1.794373e+00 ; -6.218837e-01 ];
Tc_4  = [ 2.839875e-01 ; 5.430559e-01 ; 2.043381e+00 ];
omc_error_4 = [ 1.364233e-02 ; 1.098603e-02 ; 1.847422e-02 ];
Tc_error_4  = [ 2.794668e-02 ; 2.798544e-02 ; 2.657032e-02 ];

%-- Image #5:
omc_5 = [ -1.974069e+00 ; 1.987582e+00 ; -4.312071e-01 ];
Tc_5  = [ 5.744776e-01 ; 5.154084e-01 ; 2.538836e+00 ];
omc_error_5 = [ 1.332866e-02 ; 1.028905e-02 ; 2.353899e-02 ];
Tc_error_5  = [ 3.437993e-02 ; 3.469468e-02 ; 2.547529e-02 ];

%-- Image #6:
omc_6 = [ -1.731724e+00 ; 1.719719e+00 ; -8.554479e-01 ];
Tc_6  = [ 3.649784e-01 ; 5.997843e-01 ; 3.006313e+00 ];
omc_error_6 = [ 1.396689e-02 ; 9.807531e-03 ; 1.921084e-02 ];
Tc_error_6  = [ 4.074465e-02 ; 4.090730e-02 ; 2.738043e-02 ];

%-- Image #7:
omc_7 = [ -1.789458e+00 ; 1.757343e+00 ; -8.834716e-01 ];
Tc_7  = [ 8.563330e-01 ; 6.408487e-01 ; 2.983035e+00 ];
omc_error_7 = [ 1.496847e-02 ; 1.010750e-02 ; 1.958763e-02 ];
Tc_error_7  = [ 4.118888e-02 ; 4.147955e-02 ; 3.004084e-02 ];

%-- Image #8:
omc_8 = [ -2.010672e+00 ; 2.186263e+00 ; 6.850432e-01 ];
Tc_8  = [ 6.199811e-01 ; 4.845724e-01 ; 2.478428e+00 ];
omc_error_8 = [ 9.788297e-03 ; 1.464137e-02 ; 2.257171e-02 ];
Tc_error_8  = [ 3.406942e-02 ; 3.394416e-02 ; 2.710095e-02 ];

%-- Image #9:
omc_9 = [ -1.721172e+00 ; 2.257167e+00 ; 9.736727e-01 ];
Tc_9  = [ 6.577261e-01 ; 5.292940e-01 ; 2.445776e+00 ];
omc_error_9 = [ 7.710096e-03 ; 1.596729e-02 ; 2.056518e-02 ];
Tc_error_9  = [ 3.360582e-02 ; 3.348008e-02 ; 2.664021e-02 ];

%-- Image #10:
omc_10 = [ -1.690476e+00 ; 2.191316e+00 ; 1.138904e+00 ];
Tc_10  = [ 6.165892e-01 ; 6.349322e-01 ; 2.173209e+00 ];
omc_error_10 = [ 7.573877e-03 ; 1.627987e-02 ; 1.965945e-02 ];
Tc_error_10  = [ 2.999417e-02 ; 2.974628e-02 ; 2.405887e-02 ];

%-- Image #11:
omc_11 = [ -1.866536e+00 ; 2.058717e+00 ; 5.326535e-01 ];
Tc_11  = [ 7.034627e-01 ; 4.602055e-01 ; 2.665835e+00 ];
omc_error_11 = [ 1.038413e-02 ; 1.346779e-02 ; 2.131852e-02 ];
Tc_error_11  = [ 3.628915e-02 ; 3.666051e-02 ; 2.713305e-02 ];

%-- Image #12:
omc_12 = [ -1.759252e+00 ; 1.899998e+00 ; 6.076793e-01 ];
Tc_12  = [ 6.255850e-01 ; 5.169341e-01 ; 2.597908e+00 ];
omc_error_12 = [ 9.678727e-03 ; 1.323957e-02 ; 1.846098e-02 ];
Tc_error_12  = [ 3.532174e-02 ; 3.568146e-02 ; 2.463903e-02 ];

%-- Image #13:
omc_13 = [ -2.375628e+00 ; 1.245090e+00 ; 4.521321e-02 ];
Tc_13  = [ 9.206825e-02 ; 8.256684e-01 ; 2.899084e+00 ];
omc_error_13 = [ 1.487524e-02 ; 9.245097e-03 ; 2.114550e-02 ];
Tc_error_13  = [ 3.937001e-02 ; 3.974589e-02 ; 2.874462e-02 ];

%-- Image #14:
omc_14 = [ -2.236780e+00 ; 1.100151e+00 ; 1.098073e-01 ];
Tc_14  = [ 8.075483e-02 ; 8.532594e-01 ; 3.075341e+00 ];
omc_error_14 = [ 1.423786e-02 ; 9.520243e-03 ; 1.834339e-02 ];
Tc_error_14  = [ 4.191033e-02 ; 4.242289e-02 ; 2.886498e-02 ];

%-- Image #15:
omc_15 = [ -2.127391e+00 ; 1.102623e+00 ; 1.318113e-01 ];
Tc_15  = [ 7.973938e-02 ; 7.861011e-01 ; 3.123525e+00 ];
omc_error_15 = [ 1.378832e-02 ; 9.929612e-03 ; 1.729028e-02 ];
Tc_error_15  = [ 4.250549e-02 ; 4.308456e-02 ; 2.811998e-02 ];

%-- Image #16:
omc_16 = [ 2.113781e+00 ; -1.166351e+00 ; 1.260871e-01 ];
Tc_16  = [ 1.277528e-01 ; 2.690307e-01 ; 1.941719e+00 ];
omc_error_16 = [ 1.350131e-02 ; 1.121468e-02 ; 1.890678e-02 ];
Tc_error_16  = [ 2.614382e-02 ; 2.676204e-02 ; 2.669117e-02 ];

%-- Image #17:
omc_17 = [ 8.622085e-01 ; -2.775300e+00 ; 9.899207e-01 ];
Tc_17  = [ 8.896570e-01 ; -2.993031e-01 ; 2.532990e+00 ];
omc_error_17 = [ 5.816990e-03 ; 1.766072e-02 ; 2.259453e-02 ];
Tc_error_17  = [ 3.489048e-02 ; 3.501179e-02 ; 2.588949e-02 ];

