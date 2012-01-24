%
% ** LEmpijk(ijk,a) **
% Returns the linearized body-fixed Euler angle rates matrix.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - a is a 3d vector of the angles used in the rotation sequence.
%
% This is a linearized version of Empijk(ijk,a).
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function LEp = LEmpijk(ijk,a)

if ijk(1) == 1
  if ijk(2) == 2
    if ijk(3) == 1
      % 121
      LEp = [ 1, 0, 1;
	      0, 1, 0;
	      0, -a(1), a(2)];
      return;
    end
    if ijk(3) == 3
      % 123
      LEp = [1, 0, -a(2);
	     0, 1, a(1);
	     0, -a(1), 1];
      return;
    end
  end
  if ijk(2) == 3
    if ijk(3) == 1
      % 131
      LEp = [1, 0, 1;
	     0, a(1), -a(2);
	     0, 1, 0];
      return;
    end
    if ijk(3) == 2
      % 132
      LEp = [1, 0, a(2);
	     0, a(1), 1;
	     0, 1, -a(1)];
      return;
    end
  end
end

if ijk(1) == 2
  if ijk(2) == 1
    if ijk(3) == 2
      % 212
      LEp = [0, 1, 0;
	     1, 0, 1;
	     0, a(1), -a(2)];
      return;
    end
    if ijk(3) == 3
      % 213
      LEp = [0, 1, -a(1);
	     1, 0, a(2);
	     0, a(1), 1];
      return;
    end
  end
  if ijk(2) == 3
    if ijk(3) == 1
      % 231
      LEp = [0, -a(1), 1;
	     1, 0, -a(2);
	     0, 1, a(1)];
      return;
    end
    if ijk(3) == 2
      % 232
      LEp = [0, -a(1), a(2);
	     1, 0, 1;
	     0, 1, 0];
      return;
    end
  end
end

if ijk(1) == 3
  if ijk(2) == 1
    if ijk(3) == 2
      % 312
      LEp = [0, 1, a(1);
	     0, -a(1), 1;
	     1, 0, -a(2)];
      return;
    end
    if ijk(3) == 3
      % 313
      LEp = [0, 1, 0;
	     0, -a(1), a(2);
	     1, 0, 1];
      return;
    end
  end
  if ijk(2) == 2
    if ijk(3) == 1
      % 321
      LEp = [0, a(1), 1;
	     0, 1, -a(1);
	     1, 0, a(2)];
      return;
    end
    if ijk(3) == 3
      % 323
      LEp = [0, a(1), -a(2);
	     0, 1, 0;
	     1, 0, 1];
      return;
    end
  end
end

disp('Error, sequence not valid.');
