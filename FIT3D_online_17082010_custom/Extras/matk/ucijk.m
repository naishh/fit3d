%
% ** ucijk(ijk,R) **
% Returns the vector of (i,j,k) Euler angles corresponding to the given
% rotation matrix, R.
% - ijk is a 3d vector of integers drawn from {1,2,3} without
%   adjacent elements being equal.
% - R is a rotation matrix
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function u = ucijk(ijk,R)
if ijk(1) == 1
  if ijk(2) == 2
    if ijk(3) == 1
      % 121
      u = [atan2(R(2,1), R(3,1));
	   acos(R(1,1));
	   atan2(R(1,2), -R(1,3))];
      return;
    end
    if ijk(3) == 3
      % 123
      u = [atan2(R(2,3), R(3,3));
	   -asin(R(1,3));
	   atan2(R(1,2), R(1,1))];
      return;
    end
  end
  if ijk(2) == 3
    if ijk(3) == 1
      % 131
      u = [atan2(R(3,1), -R(2,1));
	   acos(R(1,1));
	   atan2(R(1,3), R(1,2))];
      return;
    end
    if ijk(3) == 2
      % 132
      u = [atan2(-R(3,2), R(2,2));
	   asin(R(1,2));
	   atan2(-R(1,3), R(1,1))];
      return;
    end
  end
end

if ijk(1) == 2
  if ijk(2) == 1
    if ijk(3) == 2
      % 212
      u = [atan2(R(1,2), -R(3,2));
	   acos(R(2,2));
	   atan2(R(2,1), R(2,3))];
      return;
    end
    if ijk(3) == 3
      % 213
      u = [atan2(-R(1,3), R(3,3));
	   asin(R(2,3));
	   atan2(-R(2,1), R(2,2))];
      return;
    end
  end
  if ijk(2) == 3
    if ijk(3) == 1
      % 231
      u = [atan2(R(3,1), R(1,1));
	   -asin(R(2,1));
	   atan2(R(2,3), R(2,2))];
      return;
    end
    if ijk(3) == 2
      % 232
      u = [atan2(R(3,2), R(1,2));
	   acos(R(2,2));
	   atan2(R(2,3), -R(2,1))];
      return;
    end
  end
end

if ijk(1) == 3
  if ijk(2) == 1
    if ijk(3) == 2
      % 312
      u = [atan2(R(1,2), R(2,2));
	   -asin(R(3,2));
	   atan2(R(3,1), R(3,3))];
      return;
    end
    if ijk(3) == 3
      % 313
      u = [atan2(R(1,3), R(2,3));
	   acos(R(3,3));
       atan2(R(3,1), -R(3,2))];
      return;
    end
  end
  if ijk(2) == 2
    if ijk(3) == 1
      % 321
      u = [atan2(-R(2,1), R(1,1));
	   asin(R(3,1));
       atan2(-R(3,2), R(3,3))];
      return;
    end
    if ijk(3) == 3
      % 323
      u = [atan2(R(2,3), -R(1,3));
	   acos(R(3,3));
	   atan2(R(3,2), R(3,1))];
      return;
    end
  end
end

disp('Error, sequence not valid.');