%
% ** LEmijk(ijk,a) **
% Returns the linearized Euler angle rates matrix.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - a is a 3d vector of the angles used in the rotation sequence.
%
% This is a linearized version of Emijk(ijk,a).
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function LE = LEmijk(ijk,a)

if ijk(1) == 1
  if ijk(2) == 2
    if ijk(3) == 1
      % 121
      LE = [1, 0, 1;
	    0, 1, 0;
	    -a(2),  a(3), 0];
      return;
    end
    if ijk(3) == 3
      % 123
      LE = [1, -a(3), 0;
	    a(3), 1, 0;
	    -a(2), 0, 1];
      return;
    end
  end
  if ijk(2) == 3
    if ijk(3) == 1
      % 131
      LE = [1, 0, 1;
	    a(2), -a(3), 0;
	    0, 1, 0];
      return;
    end
    if ijk(3) == 2
      % 132
      LE = [1, a(3), 0;
	    a(2), 0, 1;
	    -a(3), 1, 0];
      return;
    end
  end
end

if ijk(1) == 2
  if ijk(2) == 1
    if ijk(3) == 2
      % 212
      LE = [0, 1, 0;
	    1, 0, 1;
	    a(2), -a(3), 0];
      return;
    end
    if ijk(3) == 3
      % 213
      LE = [-a(3), 1, 0;
	    1, a(3), 0;
	    a(2), 0, 1];
      return;
    end
  end
  if ijk(2) == 3
    if ijk(3) == 1
      % 231
      LE = [-a(2), 0, 1;
	    1, -a(3), 0;
	    a(3), 1, 0];
      return;
    end
    if ijk(3) == 2
      % 232
      LE = [-a(2),  a(3), 0;
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
      LE = [a(3), 1, 0;
	    -a(2), 0, 1;
	    1, -a(3), 0];
      return;
    end
    if ijk(3) == 3
      % 313
      LE = [0, 1, 0;
	    -a(2),  a(3), 0;
	    1, 0, 1];
      return;
    end
  end
  if ijk(2) == 2
    if ijk(3) == 1
      % 321
      LE = [a(2), 0, 1;
	    -a(3), 1, 0;
	    1, a(3), 0];
      return;
    end
    if ijk(3) == 3
      % 323
      LE = [a(2), -a(3), 0;
	    0, 1, 0;
	    1, 0, 1];
      return;
    end
  end
end

disp('Error, sequence not valid.');
