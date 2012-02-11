%
% ** qcslerp(q0,q1,t) **
% Returns the spherically-interpolated unit quaternion between unit 
% quaternions q0 and q1.  The interpolation parameter is t, such that when
% t = 0, the result is q0 and when t = 1, the result is q1.
% - q0 is a unit quaternion.
% - q1 is a unit quaternion.
%
% Copyright (c) 2006 James Diebel, Stanford University
%
function qs = qcslerp(q0,q1,t)
dq = qcm(qcadj(q0),q1);
qs = qcm(q0,qcexp(dq,t));