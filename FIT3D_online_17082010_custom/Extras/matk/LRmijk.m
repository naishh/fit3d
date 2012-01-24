%
% ** LRmijk(ijk,a) **
% Returns the linearized rotation matrix arising from the ijk
% sequence of coordinate rotations.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - a is a 3d vector of the angles used in the rotation sequence.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function LR = LRmijk(ijk,a)
if ijk(1) == 1
  if ijk(2) == 2
    if ijk(3) == 1
      % 121
      LR = [1, 0, -a(2);
	    0, 1, a(3)+a(1);
	    a(2), -a(1)-a(3), 1];
      return;
    end
    if ijk(3) == 3
      % 123
      LR = [1, a(3), -a(2);
	    -a(3), 1, a(1);
	    a(2), -a(1), 1];
      return;
    end
  end
  if ijk(2) == 3
    if ijk(3) == 1
      % 131
      LR = [1, a(2), 0;
	    -a(2), 1, a(3)+a(1);
	    0, -a(1)-a(3), 1];
      return;
    end
    if ijk(3) == 2
      % 132
      LR = [1, a(2), -a(3);
	    -a(2), 1, a(1);
	    a(3), -a(1), 1];
      return;
    end
  end
end

if ijk(1) == 2
  if ijk(2) == 1
    if ijk(3) == 2
      % 212
      LR = [1, 0, -a(3)-a(1);
	    0, 1, a(2);
	    a(1)+a(3), -a(2),1 ];
      return;
    end
    if ijk(3) == 3
      % 213
      LR = [1, a(3), -a(1);
	    -a(3), 1, a(2);
	    a(1), -a(2), 1];
      return;
    end
  end
  if ijk(2) == 3
    if ijk(3) == 1
      % 231
      LR = [1, a(2), -a(1);
	    -a(2), 1, a(3);
	    a(1), -a(3), 1];
      return;
    end
    if ijk(3) == 2
      % 232
      LR = [1, a(2), -a(3)-a(1);
	    -a(2), 1, 0;
	    a(1)+a(3), 0, 1];
      return;
    end
  end
end

if ijk(1) == 3
  if ijk(2) == 1
    if ijk(3) == 2
      % 312
      LR = [1, a(1), -a(3);
	    -a(1), 1, a(2);
	    a(3), -a(2), 1];
      return;
    end
    if ijk(3) == 3
      % 313
      LR = [1, a(1)+a(3), 0;
	    -a(3)-a(1), 1, a(2);
	    0, -a(2), 1];
      return;
    end
  end
  if ijk(2) == 2
    if ijk(3) == 1
      % 321
      LR = [1, a(1), -a(2);
	    -a(1), 1, a(3);
	    a(2), -a(3), 1];
      return;
    end
    if ijk(3) == 3
      % 323
      LR = [1, a(1)+a(3), -a(2);
	    -a(3)-a(1), 1, 0;
	    a(2), 0, 1];
      return;
    end
  end
end
  
disp('Error, sequence not valid.');
