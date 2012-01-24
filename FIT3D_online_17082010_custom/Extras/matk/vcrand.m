%
% ** vcrand() **
% Returns a random rotation vector.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function vr = vcrand()
nr = rand(3,1);
nrn = norm(nr);
if nrn == 0
  nr(1) = 1e-6;
  nrn = norm(nr);
end
nr = nr/nrn;
vr = 2*pi*nr-pi;