% getNRandom - Get n random numbers (integers) out of a set, all different
%
%
%
% Input  - n    -> (1x1) Number of random numbers
%        - K    -> (1x1) Maximum number
%
% Output - R    -> (1xn) List of random numbers (all different)
%          
%
%
% Author: Isaac Esteban
% IAS, University of Amsterdam
% TNO Defense, Security and Safety
% isaac@fit3d.info
% isaac.esteban@tno.nl
% Copyright TNO - 2010

function R = getNRandom(n,K)

    
    % Get all posible numbers
    N = randperm(K);
    
    % Get n of them
    R = N(1:n)';
