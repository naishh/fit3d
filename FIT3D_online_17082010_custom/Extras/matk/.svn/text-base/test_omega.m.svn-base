clear all;
close all;
clc;

ijk = [1 2 3];

du = 1e-3*rand(3,1);
u1 = 2*pi*rand(3,1);
u2 = u1+du;
R1 = Rmijk(ijk,u1);
R2 = Rmijk(ijk,u2);
Eu1 = Emijk(ijk,u1);
Epu1 = Empijk(ijk,u1);

q1 = qcR(R1);
q2 = qcR(R2);
dq = q2-q1;
Wq1 = Wmq(q1);
Wpq1 = Wmpq(q1);
Qq1 = Qmq(q1);
Qbq1 = Qmbq(q1);

v1 = vcR(R1);
v2 = vcR(R2);
dv = v2-v1;
Vv1 = Vmv(v1);
Vpv1 = Vmpv(v1);

omegau1 = Eu1*du;
omegapu1 = Epu1*du;
omegaq1 = 2*Wq1*dq;
omegapq1 = 2*Wpq1*dq;
omegav1 = 2*Vv1*dv;
omegapv1 = 2*Vpv1*dv;
omega = 1000*[omegau1 omegaq1 omegav1]
omegap = 1000*[omegapu1 omegapq1 omegapv1]
domega = 100*[norm((omegau1-omegaq1)./omegaq1)...
    norm((omegav1-omegaq1)./omegaq1)]
domegap = 100*[norm((omegapu1-omegapq1)./omegapq1)...
    norm((omegapv1-omegapq1)./omegapq1)]

test = 2*Qq1'*dq;
testp = 2*Qbq1'*dq;
