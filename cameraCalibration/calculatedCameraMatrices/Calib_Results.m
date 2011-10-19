% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3305.303907259784864 ; 3325.725324332339824 ];

%-- Principal point:
cc = [ 1575.131731314702847 ; 1189.458165445019404 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.192291859589209 ; 0.180419091883563 ; -0.000355539996573 ; 0.000147492955222 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 3.712303670002851 ; 3.875990254122743 ];

%-- Principal point uncertainty:
cc_error = [ 8.185028106809309 ; 6.998297852973649 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.006726797070194 ; 0.032004489678058 ; 0.000433314824008 ; 0.000487170644297 ; 0.000000000000000 ];

%-- Image size:
nx = 3072;
ny = 2304;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 34;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.175588e+00 ; -2.181238e+00 ; -4.068779e-02 ];
Tc_1  = [ -4.193348e+02 ; -4.116521e+02 ; 1.554751e+03 ];
omc_error_1 = [ 2.545649e-03 ; 2.542277e-03 ; 5.485169e-03 ];
Tc_error_1  = [ 3.922291e+00 ; 3.342988e+00 ; 2.775949e+00 ];

%-- Image #2:
omc_2 = [ -2.206124e+00 ; -2.228651e+00 ; -9.431136e-02 ];
Tc_2  = [ -6.078072e+02 ; -4.029968e+02 ; 1.509848e+03 ];
omc_error_2 = [ 2.639504e-03 ; 2.389985e-03 ; 5.507914e-03 ];
Tc_error_2  = [ 3.822328e+00 ; 3.307041e+00 ; 2.949329e+00 ];

%-- Image #3:
omc_3 = [ NaN ; NaN ; NaN ];
Tc_3  = [ NaN ; NaN ; NaN ];
omc_error_3 = [ NaN ; NaN ; NaN ];
Tc_error_3  = [ NaN ; NaN ; NaN ];

%-- Image #4:
omc_4 = [ -1.910615e+00 ; -1.892782e+00 ; 4.720151e-01 ];
Tc_4  = [ -4.279929e+02 ; -4.035379e+02 ; 1.949210e+03 ];
omc_error_4 = [ 2.318334e-03 ; 1.983128e-03 ; 3.839119e-03 ];
Tc_error_4  = [ 4.868974e+00 ; 4.138651e+00 ; 2.608197e+00 ];

%-- Image #5:
omc_5 = [ -1.648744e+00 ; -1.878712e+00 ; 1.179643e-01 ];
Tc_5  = [ -3.506152e+02 ; -4.973895e+02 ; 1.755355e+03 ];
omc_error_5 = [ 1.962449e-03 ; 2.163094e-03 ; 3.412435e-03 ];
Tc_error_5  = [ 4.407138e+00 ; 3.732085e+00 ; 2.609604e+00 ];

%-- Image #6:
omc_6 = [ -1.561182e+00 ; -1.565211e+00 ; 9.240056e-02 ];
Tc_6  = [ -1.434201e+02 ; -4.988047e+02 ; 1.821042e+03 ];
omc_error_6 = [ 1.851798e-03 ; 2.137617e-03 ; 2.913578e-03 ];
Tc_error_6  = [ 4.577185e+00 ; 3.853450e+00 ; 2.507333e+00 ];

%-- Image #7:
omc_7 = [ -1.937904e+00 ; -1.822981e+00 ; 7.855455e-01 ];
Tc_7  = [ -1.188492e+02 ; -3.452762e+02 ; 2.075900e+03 ];
omc_error_7 = [ 2.350183e-03 ; 1.865558e-03 ; 3.726059e-03 ];
Tc_error_7  = [ 5.161721e+00 ; 4.349679e+00 ; 2.308758e+00 ];

%-- Image #8:
omc_8 = [ 1.748770e+00 ; 1.760768e+00 ; 4.086579e-01 ];
Tc_8  = [ -6.028632e+02 ; -4.232986e+02 ; 1.586576e+03 ];
omc_error_8 = [ 2.052214e-03 ; 2.127029e-03 ; 3.440260e-03 ];
Tc_error_8  = [ 4.111367e+00 ; 3.464603e+00 ; 2.890103e+00 ];

%-- Image #9:
omc_9 = [ -2.086783e+00 ; -2.071062e+00 ; -1.080289e+00 ];
Tc_9  = [ -5.037025e+02 ; -3.692735e+02 ; 1.363594e+03 ];
omc_error_9 = [ 1.801301e-03 ; 2.390139e-03 ; 4.159150e-03 ];
Tc_error_9  = [ 3.547833e+00 ; 3.056271e+00 ; 2.772157e+00 ];

%-- Image #10:
omc_10 = [ 2.074866e+00 ; 1.964644e+00 ; 2.644854e-01 ];
Tc_10  = [ -3.832920e+02 ; -4.460156e+02 ; 1.624760e+03 ];
omc_error_10 = [ 2.443208e-03 ; 2.295706e-03 ; 4.684697e-03 ];
Tc_error_10  = [ 4.119596e+00 ; 3.468347e+00 ; 2.950579e+00 ];

%-- Image #11:
omc_11 = [ -2.022658e+00 ; -1.845128e+00 ; 1.615618e-01 ];
Tc_11  = [ -1.624578e+02 ; -2.608892e+02 ; 1.963143e+03 ];
omc_error_11 = [ 2.402604e-03 ; 2.660859e-03 ; 4.679532e-03 ];
Tc_error_11  = [ 4.867806e+00 ; 4.135773e+00 ; 2.882341e+00 ];

%-- Image #12:
omc_12 = [ -1.425490e+00 ; -2.007232e+00 ; 2.799668e-01 ];
Tc_12  = [ -2.852049e+02 ; -5.358823e+02 ; 2.058649e+03 ];
omc_error_12 = [ 1.982250e-03 ; 2.378091e-03 ; 3.410182e-03 ];
Tc_error_12  = [ 5.154152e+00 ; 4.359403e+00 ; 3.025526e+00 ];

%-- Image #13:
omc_13 = [ -1.746471e+00 ; -1.736357e+00 ; -5.807464e-01 ];
Tc_13  = [ -4.158801e+02 ; -3.389307e+02 ; 1.225393e+03 ];
omc_error_13 = [ 1.643545e-03 ; 2.158283e-03 ; 3.200360e-03 ];
Tc_error_13  = [ 3.101521e+00 ; 2.673960e+00 ; 2.129176e+00 ];

%-- Image #14:
omc_14 = [ 1.944523e+00 ; 1.899294e+00 ; -3.934340e-01 ];
Tc_14  = [ -4.298384e+02 ; -4.168547e+02 ; 1.607069e+03 ];
omc_error_14 = [ 1.701358e-03 ; 2.164841e-03 ; 3.746786e-03 ];
Tc_error_14  = [ 4.027661e+00 ; 3.412156e+00 ; 2.267447e+00 ];

%-- Image #15:
omc_15 = [ 1.866470e+00 ; 1.726544e+00 ; 1.472185e-01 ];
Tc_15  = [ -6.068475e+02 ; -4.465274e+02 ; 1.553687e+03 ];
omc_error_15 = [ 1.938762e-03 ; 2.156159e-03 ; 3.499678e-03 ];
Tc_error_15  = [ 3.974233e+00 ; 3.375690e+00 ; 2.796649e+00 ];

%-- Image #16:
omc_16 = [ 1.952630e+00 ; 1.779900e+00 ; 1.293782e-02 ];
Tc_16  = [ -3.925511e+02 ; -4.465968e+02 ; 1.610693e+03 ];
omc_error_16 = [ 2.044874e-03 ; 2.089368e-03 ; 3.784086e-03 ];
Tc_error_16  = [ 4.055131e+00 ; 3.417791e+00 ; 2.569567e+00 ];

%-- Image #17:
omc_17 = [ 1.900813e+00 ; 1.936117e+00 ; -7.214862e-02 ];
Tc_17  = [ -1.704663e+02 ; -4.431944e+02 ; 1.651370e+03 ];
omc_error_17 = [ 2.097571e-03 ; 2.115958e-03 ; 3.985378e-03 ];
Tc_error_17  = [ 4.145948e+00 ; 3.471054e+00 ; 2.412032e+00 ];

%-- Image #18:
omc_18 = [ 2.178475e+00 ; 2.038290e+00 ; 9.293440e-01 ];
Tc_18  = [ -4.816843e+02 ; -3.331566e+02 ; 1.328937e+03 ];
omc_error_18 = [ 2.648733e-03 ; 1.738829e-03 ; 4.108152e-03 ];
Tc_error_18  = [ 3.437445e+00 ; 2.949643e+00 ; 2.659310e+00 ];

%-- Image #19:
omc_19 = [ -2.112827e+00 ; -2.110631e+00 ; 2.846414e-01 ];
Tc_19  = [ -4.415795e+02 ; -4.359047e+02 ; 2.071295e+03 ];
omc_error_19 = [ 2.972149e-03 ; 2.693145e-03 ; 5.856933e-03 ];
Tc_error_19  = [ 5.175966e+00 ; 4.394908e+00 ; 3.064089e+00 ];

%-- Image #20:
omc_20 = [ -1.396462e+00 ; -1.558839e+00 ; 6.675998e-01 ];
Tc_20  = [ -2.427298e+02 ; -5.446908e+02 ; 2.095472e+03 ];
omc_error_20 = [ 2.192091e-03 ; 2.073416e-03 ; 2.671577e-03 ];
Tc_error_20  = [ 5.263544e+00 ; 4.423516e+00 ; 2.708786e+00 ];

%-- Image #21:
omc_21 = [ NaN ; NaN ; NaN ];
Tc_21  = [ NaN ; NaN ; NaN ];
omc_error_21 = [ NaN ; NaN ; NaN ];
Tc_error_21  = [ NaN ; NaN ; NaN ];

%-- Image #22:
omc_22 = [ 1.935438e+00 ; -9.389028e-01 ; 3.445757e-01 ];
Tc_22  = [ -9.127131e+00 ; 1.890037e+02 ; 1.031363e+03 ];
omc_error_22 = [ 2.085564e-03 ; 1.937469e-03 ; 2.740161e-03 ];
Tc_error_22  = [ 2.578220e+00 ; 2.219081e+00 ; 2.006492e+00 ];

%-- Image #23:
omc_23 = [ 2.024964e+00 ; -9.678566e-01 ; 3.261681e-01 ];
Tc_23  = [ -1.662890e+01 ; 4.919710e+01 ; 1.089823e+03 ];
omc_error_23 = [ 2.109458e-03 ; 2.004139e-03 ; 2.859458e-03 ];
Tc_error_23  = [ 2.699014e+00 ; 2.351134e+00 ; 2.038254e+00 ];

%-- Image #24:
omc_24 = [ -1.404156e+00 ; -1.402514e+00 ; -1.078567e+00 ];
Tc_24  = [ -4.188755e+02 ; -3.604156e+02 ; 1.160587e+03 ];
omc_error_24 = [ 1.805301e-03 ; 2.257993e-03 ; 2.613411e-03 ];
Tc_error_24  = [ 2.980337e+00 ; 2.597053e+00 ; 2.175290e+00 ];

%-- Image #25:
omc_25 = [ -1.496120e+00 ; -1.483197e+00 ; -1.027823e+00 ];
Tc_25  = [ -4.317711e+02 ; -1.329539e+02 ; 1.189254e+03 ];
omc_error_25 = [ 1.829042e-03 ; 2.341188e-03 ; 2.734080e-03 ];
Tc_error_25  = [ 2.972758e+00 ; 2.583641e+00 ; 2.140200e+00 ];

%-- Image #26:
omc_26 = [ -1.581719e+00 ; -1.551767e+00 ; -9.430557e-01 ];
Tc_26  = [ -4.027881e+02 ; 6.311823e+01 ; 1.192807e+03 ];
omc_error_26 = [ 1.812397e-03 ; 2.425136e-03 ; 2.859622e-03 ];
Tc_error_26  = [ 2.968717e+00 ; 2.578271e+00 ; 2.088572e+00 ];

%-- Image #27:
omc_27 = [ -1.640240e+00 ; -1.651715e+00 ; -8.561040e-01 ];
Tc_27  = [ -4.118732e+02 ; 1.152465e+02 ; 1.196339e+03 ];
omc_error_27 = [ 1.768645e-03 ; 2.458672e-03 ; 3.003347e-03 ];
Tc_error_27  = [ 2.981364e+00 ; 2.606977e+00 ; 2.113204e+00 ];

%-- Image #28:
omc_28 = [ -1.626786e+00 ; -1.616592e+00 ; -8.762572e-01 ];
Tc_28  = [ -4.115828e+02 ; 4.714457e+01 ; 1.202612e+03 ];
omc_error_28 = [ 1.767066e-03 ; 2.420984e-03 ; 2.971365e-03 ];
Tc_error_28  = [ 2.989337e+00 ; 2.601602e+00 ; 2.103350e+00 ];

%-- Image #29:
omc_29 = [ -1.589546e+00 ; -1.588389e+00 ; -9.049793e-01 ];
Tc_29  = [ -4.158663e+02 ; -5.002286e+01 ; 1.190749e+03 ];
omc_error_29 = [ 1.759660e-03 ; 2.374645e-03 ; 2.913080e-03 ];
Tc_error_29  = [ 2.960348e+00 ; 2.569911e+00 ; 2.090352e+00 ];

%-- Image #30:
omc_30 = [ -1.495282e+00 ; -1.476806e+00 ; -9.932835e-01 ];
Tc_30  = [ -4.199509e+02 ; -2.963215e+02 ; 1.116927e+03 ];
omc_error_30 = [ 1.742479e-03 ; 2.242017e-03 ; 2.725429e-03 ];
Tc_error_30  = [ 2.842135e+00 ; 2.471695e+00 ; 2.064286e+00 ];

%-- Image #31:
omc_31 = [ -1.162172e+00 ; -1.974353e+00 ; 2.820768e-01 ];
Tc_31  = [ -1.913713e+02 ; -5.687974e+02 ; 2.129172e+03 ];
omc_error_31 = [ 1.866582e-03 ; 2.456508e-03 ; 3.066724e-03 ];
Tc_error_31  = [ 5.332990e+00 ; 4.500364e+00 ; 3.204529e+00 ];

%-- Image #32:
omc_32 = [ 2.687041e+00 ; 1.578254e+00 ; -1.225593e-02 ];
Tc_32  = [ -5.654779e+02 ; -2.011402e+02 ; 2.174291e+03 ];
omc_error_32 = [ 4.997531e-03 ; 3.139724e-03 ; 9.220753e-03 ];
Tc_error_32  = [ 5.437965e+00 ; 4.631015e+00 ; 4.306051e+00 ];

%-- Image #33:
omc_33 = [ -1.787144e+00 ; -2.420656e+00 ; 8.845293e-01 ];
Tc_33  = [ -2.995360e+02 ; -4.372583e+02 ; 2.501130e+03 ];
omc_error_33 = [ 2.692826e-03 ; 2.346957e-03 ; 4.577621e-03 ];
Tc_error_33  = [ 6.232617e+00 ; 5.319048e+00 ; 3.006876e+00 ];

%-- Image #34:
omc_34 = [ 2.238320e+00 ; 1.485682e+00 ; 1.437531e+00 ];
Tc_34  = [ -3.674675e+02 ; -9.363077e+01 ; 1.401966e+03 ];
omc_error_34 = [ 3.041842e-03 ; 1.507631e-03 ; 3.535209e-03 ];
Tc_error_34  = [ 3.554651e+00 ; 3.028239e+00 ; 2.734746e+00 ];

