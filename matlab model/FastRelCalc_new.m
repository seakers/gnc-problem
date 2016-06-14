function rel = FastRelCalc_new(Rs,Rc,Ijk)
% FastRelCalc.m
% Quickly calculates the reliability of a 3x2 GNC system given the
% reliabilities of the sensors, computers and interconnections and the way
% elements are connected.
% Usage:
% rel = FastRelCalc_new(Rs,Rc,Ijk);
% Inputs:
% Rs = [0.99 0.99 0.9996]'; % Reliabilities of the three sensors of the
% architecture (different of the reliabilities of the three different
% types!) or zero if absent.
% Rc = [0.999 0.9996 0.999]'; % Reliabilities of the three computers of the
% architecture or zero if absent.
% Ijk = 0.99995.*[1 1 1;1 0 1;0 1 1]; % Reliability of each interconnection
% or zero if not connected.
% Reliability is calculated by applying an expression which was found using
% CalcReliability_new.m with a symbolic 3x2 cross-strapped architecture.
% Absent elements have zero reliability thus giving a correct result.
ns = length(Rs);
nc = length(Rc);

s1 = Rs(1);
if ns > 1
    s2 = Rs(2);
else
    s2 = 0;
end

if ns > 2
    s3 = Rs(3);
else
    s3 = 0;
end

c1 = Rc(1);

if nc > 1
    c2 = Rc(2);
else
    c2 = 0;
end

if nc > 2
    c3 = Rc(3);
else
    c3 = 0;
end

i11 = Ijk(1,1);

if nc > 1
    i12 = Ijk(1,2);
else
    i12 = 0;
end

if nc > 2
    i13 = Ijk(1,3);
else
    i13 = 0;
end

if ns > 1
    i21 = Ijk(2,1);
else
    i21 = 0;
end

if ns > 1 && nc > 1
    i22 = Ijk(2,2);
else
    i22 = 0;
end

if ns > 1 && nc > 2
    i23 = Ijk(2,3);
else
    i23 = 0;
end

if ns > 2
    i31 = Ijk(3,1);
else
    i31 = 0;
end

if ns > 2 && nc > 1
    i32 = Ijk(3,2);
else
    i32 = 0;
end

if ns > 2 && nc > 2
    i33 = Ijk(3,3);
else
    i33 = 0;
end

rel = s1*i12*c2+s1*i11*c1+s3*i33*c3+s1*i13*c3+s3*i32*c2+s2*i23*c3+s2*i22*c2+s3*i31*c1+s2*i21*c1+s1*s3*i12*i31*c1*c2*i32-s1*s3*i13*i31*c1*c3-s1*s2*i12*c2*i22+s3*i13*i23*i31*i33*c1*c2*s1*s2*i32*c3-s3*i13*i23*i31*i33*c1*c2*s1*s2*i11*i32*c3+s3*i13*i23*i31*i33*c1*c2*s1*s2*i12*c3-s3*i13*i23*i31*i33*c1*c2*s1*s2*i11*i12*c3-s3*i13*i22*i23*i31*i33*c1*c2*s1*s2*i11*c3-s1*s2*i11*i12*i22*i23*i31*i33*c2*s3*c1*c3-s2*s3*i23*i33*c3+s1*i12*i13*i31*i32*c1*c2*s3*i11*c3+s1*i12*i13*i31*i32*c1*c2*s3*i33*c3-s1*i12*i13*i31*i32*c1*c2*s3*c3+s1*i12*i13*i31*i32*c1*c2*s2*s3*i22*c3-s1*i12*i13*i31*i32*c1*c2*s2*s3*i23*i33*c3+s1*i12*i13*i31*i32*c1*c2*s2*s3*i11*i23*i33*c3-s1*i12*i13*i31*i32*c1*c2*s2*s3*i11*i22*c3-s1*i12*i13*i31*i32*c1*c2*s3*i11*i33*c3+s1*i12*i13*i31*i32*c1*c2*s2*s3*i23*c3-s1*i12*i13*i31*i32*c1*c2*s2*s3*i11*i23*c3+s3*i13*i22*i23*i31*i33*c1*c2*s1*s2*c3-s1*s2*i13*i21*c1*c3+s1*i13*i21*i23*i32*c3*s2*s3*i33*c1*c2-s1*i13*i21*i23*i32*c3*s2*s3*c1*c2+s1*i13*i21*i23*i32*c3*s2*s3*i11*c1*c2+s1*i13*i21*i23*i32*c3*s2*s3*i22*c1*c2-s1*i13*i21*i23*i32*c3*s2*s3*i11*i22*c1*c2-s1*i13*i21*i23*i32*c3*s2*s3*i11*i33*c1*c2+s2*i12*i13*i22*i31*i33*c2*c3*s1*s3*c1-s2*i12*i13*i22*i31*i33*c2*c3*s1*s3*i11*c1-s2*i12*i13*i22*i31*i33*c2*c3*s1*s3*i23*c1+s1*s2*s3*i11*i12*i13*i21*i22*i23*i31*i32*i33*c1*c2*c3+s2*s3*i22*i23*i33*c2*c3-s1*s2*i11*i12*i22*i23*i33*c1*c2*s3*i13*c3-s1*s2*i11*i12*i22*i23*i33*c1*c2*s3*i32*c3+s1*s2*i11*i12*i22*i23*i33*c1*c2*s3*c3-s2*i12*i21*i23*i33*c1*c3*s1*s3*c2+s2*i12*i21*i23*i33*c1*c3*s1*s3*i22*c2+s2*i12*i21*i23*i33*c1*c3*s1*s3*i11*c2-s2*i21*i31*c1*c2*s1*s3*i12*i23*c3+s2*i21*i31*c1*c2*s3*i22*i23*i32*c3-s2*i21*i31*c1*c2*s1*s3*i13*i32*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12*i13*i22*c3+s2*i21*i31*c1*c2*s1*s3*i12*i13*i22*c3+s2*i21*i31*c1*c2*s1*s3*i11*i13*i22*c3+s2*i21*i31*c1*c2*s3*i32-s2*i21*i31*c1*c2*s3*i23*i32*c3+s2*i11*i12*i21*i23*i32*c1*c3*s1*s3*c2-s2*i11*i12*i21*i23*i32*c1*c3*s1*s3*i22*c2-s2*i11*i12*i21*i23*i32*c1*c3*s1*s3*i33*c2+s2*i12*i13*i21*i32*c1*s1*s3*i23*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i31*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i33*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i22*i31*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i11*i23*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i22*i23*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i22*i33*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i11*i31*c2*c3+s1*s2*i22*i23*i31*i32*c1*c2*s3*i11*c3+s1*s2*i22*i23*i31*i32*c1*c2*s3*i13*c3+s1*s2*i22*i23*i31*i32*c1*c2*s3*i12*c3-s1*s2*i22*i23*i31*i32*c1*c2*s3*i11*i33*c3+s1*s2*i22*i23*i31*i32*c1*c2*s3*i11*i12*i33*c3+s1*s2*i22*i23*i31*i32*c1*c2*s3*i11*i13*i33*c3+s1*s2*i22*i23*i31*i32*c1*c2*s3*i12*i13*i33*c3-s1*s2*i22*i23*i31*i32*c1*c2*s3*i11*i12*i13*i33*c3-s1*s2*i22*i23*i31*i32*c1*c2*s3*i11*i13*c3-s1*s2*i22*i23*i31*i32*c1*c2*s3*i12*i13*c3+s1*s2*i22*i23*i31*i32*c1*c2*s3*i11*i12*i13*c3-s1*s3*i13*i33*c3+s2*i21*i31*c1*c2*s3*i22*i23*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i22*i33*c3-s2*i21*i31*c1*c2*s3*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12*i23*i32*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i23*i32*c3-s2*i21*i31*c1*c2*s1*s3*i11*i22*i23*i32*c3-s2*i21*i31*c1*c2*s1*s3*i12*i22*i23*i32*c3-s2*i21*i31*c1*c2*s1*s3*i11*i13*i23*i32*c3-s2*i21*i31*c1*c2*s1*s3*i13*i22*i23*i32*c3+s2*i21*i31*c1*c2*s1*s3*i11*i13*i22*i23*i32*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i22*i23*i32*c3+s2*i21*i31*c1*c2*s1*s3*i11*i13*i32*c3+s2*i21*i31*c1*c2*s1*s3*i13*i22*i32*c3+s2*i21*i31*c1*c2*s1*s3*i12*i23*i32*c3+s2*i21*i31*c1*c2*s1*s3*i13*i23*i32*c3-s2*i21*i31*c1*c2*s1*s3*i11*i13*i22*i32*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i32+s2*i21*i31*c1*c2*s3*i22-s2*i21*i31*c1*c2*s1*s3*i11*i12*i13*i23*c3-s2*i21*i31*c1*c2*s1*s3*i12*i13*c3+s2*i21*i31*c1*c2*s1*s3*i11*i22*i32+s2*i21*i31*c1*c2*s1*s3*i12*i22*i32-s2*i21*i31*c1*c2*s1*s3*i11*i12*i22*i32-s2*i21*i31*c1*c2*s3*i22*i23*c3-s2*i21*i31*c1*c2*s3*i22*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12-s2*i21*i31*c1*c2*s1*s3*i11*i22-s2*i21*i31*c1*c2*s1*s3*i12*i22+s2*i21*i31*c1*c2*s1*s3*i12-s2*i21*i31*c1*c2*s3*i22*i32-s1*s2*i22*i23*i31*i32*c1*c2*s3*i11*i12*c3-s1*s2*i22*i23*i31*i32*c1*c2*s3*i13*i33*c3-s1*s2*i22*i23*i31*i32*c1*c2*s3*i12*i33*c3-s2*s3*i11*i12*i21*i22*i33*c1*c3*s1*i23*c2-s2*s3*i11*i12*i21*i22*i33*c1*c3*s1*i13*c2-s2*s3*i11*i12*i21*i22*i33*c1*c3*s1*i32*c2+s2*s3*i11*i12*i21*i22*i33*c1*c3*s1*c2+s2*s3*i11*i12*i21*i22*i33*c1*c3*s1*i23*i32*c2+s2*s3*i11*i12*i21*i22*i33*c1*c3*s1*i13*i23*c2-s2*i12*i13*i21*i32*c1*s1*s3*i23*i31*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i31*i33*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i23*i33*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i11*i22*i33*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i11*i33*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i11*i22*i23*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i11*i22*i31*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i11*i23*i31*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i22*i23*i31*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i11*i22*i23*i31*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i22*i31*i33*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i11*i23*i33*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i22*i23*i33*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i11*i31*i33*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i11*i22*i23*i33*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i11*i22*i31*i33*c2*c3-s2*i12*i13*i21*i32*c1*s1*s3*i11*i22*c2*c3-s1*i11*i12*c1*c2+s1*s2*i11*i21*i23*c1*c3-s2*i12*i13*i21*i32*c1*s1*s3*c2*c3-s2*i21*i31*c1*c2*s1*s3*i12*i32-s2*i21*i31*c1*c2*s1*s3*i11*i32-s2*i21*i31*c1*c2*s3*i22*i23*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i13*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i13*i22*i33*c3-s2*i21*i31*c1*c2*s1*s3*i12*i13*i22*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i13*i22*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12*i22*i33*c3-s2*i21*i31*c1*c2*s1*s3*i12*i33*c3+s2*i21*i31*c1*c2*s3*i23*i32*i33*c3+s2*i21*i31*c1*c2*s3*i22*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i12*i22*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i23*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i22*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i12*i22*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i23*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i22*i23*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i12*i22*i23*i32*i33*c3+s2*i12*i13*i21*i32*c1*s1*s3*i22*c2*c3+s2*i12*i13*i21*i32*c1*s1*s3*i11*c2*c3-s2*i13*i21*i23*i31*i32*i33*c3*s1*s3*c1*c2+s2*i13*i21*i23*i31*i32*i33*c3*s1*s3*i22*c1*c2+s2*i13*i21*i23*i31*i32*i33*c3*s1*s3*i12*c1*c2+s2*i13*i21*i23*i31*i32*i33*c3*s1*s3*i11*c1*c2-s2*i13*i21*i23*i31*i32*i33*c3*s1*s3*i11*i12*c1*c2-s2*i13*i21*i23*i31*i32*i33*c3*s1*s3*i11*i22*c1*c2-s2*i13*i21*i23*i31*i32*i33*c3*s1*s3*i12*i22*c1*c2-s1*i12*i13*i22*i32*i33*c1*c2*s2*s3*i31*c3-s1*i12*i13*i22*i32*i33*c1*c2*s2*s3*i11*c3+s1*i12*i13*i22*i32*i33*c1*c2*s2*s3*i11*i23*c3+s1*i12*i13*i22*i32*i33*c1*c2*s2*s3*i11*i31*c3+s1*s2*i11*i12*i13*i22*i23*i31*i33*c1*s3*c2*c3-s3*i13*i21*i22*i23*i32*i33*c2*s1*s2*c1*c3+s3*i13*i21*i22*i23*i32*i33*c2*s1*s2*i11*c1*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i13*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i23*c3+s2*i21*i31*c1*c2*s1*s3*i12*i22*i23*c3+s2*i21*i31*c1*c2*s1*s3*i12*i13*i23*c3+s2*i21*i31*c1*c2*s1*s3*i13*i22*i23*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i13*i22*i23*c3-s2*i21*i31*c1*c2*s1*s3*i12*i13*i22*i23*c3-s2*i21*i31*c1*c2*s1*s3*i11*i13*i22*i23*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12*i22*i23*c3+s2*i21*i31*c1*c2*s1*s3*i12*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i22-s2*i21*i31*c1*c2*s1*s3*i11*i12*i22*i23*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i13*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i13*i22*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i12*i23*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i13*i22*i32*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i22*i32*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12*i13*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12*i23*i33*c3-s2*i21*i31*c1*c2*s1*s3*i12*i22*i23*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i13*i23*i33*c3-s2*i21*i31*c1*c2*s1*s3*i12*i13*i23*i33*c3-s2*i21*i31*c1*c2*s1*s3*i13*i22*i23*i33*c3-s2*i21*i31*c1*c2*s1*s3*i11*i12*i13*i22*i23*i33*c3+s2*i21*i31*c1*c2*s1*s3*i12*i13*i22*i23*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i13*i22*i23*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i12*i22*i23*i33*c3+s2*i21*i31*c1*c2*s1*s3*i12*i13*i33*c3+s2*i21*i31*c1*c2*s1*s3*i13*i22*i33*c3+s2*i21*i31*c1*c2*s1*s3*i12*i23*i33*c3+s2*i21*i31*c1*c2*s1*s3*i11*i22*i23*c3-s2*i21*i31*c1*c2*s1*s3*i11*i22*i23*i33*c3-s2*i21*i31*c1*c2*s1*s3*i13*i22*c3+s1*s2*i21*i31*c1*s3*i13*i23*i33*c3+s1*s2*i21*i31*c1*s3*i11*i13*i33*c3-s1*s2*i21*i31*c1*s3*i11*i13*c3+s1*s2*i21*i31*c1*s3*i11*i13*i23*c3-s1*s2*i21*i31*c1*s3*i13*i23*c3+s1*s2*i21*i31*c1*s3*i11+s1*s2*i21*i31*c1*s3*i11*i23*i33*c3-s1*s2*i21*i31*c1*s3*i13*i33*c3-s1*s2*i21*i31*c1*s3*i11*i13*i23*i33*c3-s2*s3*i22*i31*c1*c2-s3*i32*i33*c2*c3+s1*s2*i21*i31*c1*s3*i13*c3-s1*s2*i21*i31*c1*s3*i11*i23*c3-s1*s2*i21*i31*c1*s3*i11*i33*c3-s2*i12*i21*i23*i33*c1*c3*s1*s3*i11*i13*c2-s2*i12*i21*i23*i33*c1*c3*s1*s3*i13*i22*c2-s2*i12*i21*i23*i33*c1*c3*s1*s3*i22*i32*c2+s2*i12*i21*i23*i33*c1*c3*s1*s3*i13*c2+s2*i12*i21*i23*i33*c1*c3*s1*s3*i32*c2-s1*s3*i12*i32*c2-s2*i11*i13*i21*i22*i33*c1*s1*s3*i32*c2*c3+s2*i11*i13*i21*i22*i33*c1*s1*s3*c2*c3-s2*i11*i13*i21*i22*i33*c1*s1*s3*i23*c2*c3-s2*i13*i21*i33*c1*c3*s1*s3*i23-s2*i13*i21*i33*c1*c3*s1*s3*i22*c2-s2*i13*i21*i33*c1*c3*s1*s3*i12*c2+s2*i13*i21*i33*c1*c3*s1*s3*i11*i23+s2*i13*i21*i33*c1*c3*s1*s3*i22*i23*c2+s2*i13*i21*i33*c1*c3*s1*s3*i22*i32*c2+s2*i13*i21*i33*c1*c3*s1*s3*i11*i32*c2-s2*i13*i21*i33*c1*c3*s1*s3*i11+s2*i13*i21*i33*c1*c3*s1*s3*i11*i12*c2+s2*i13*i21*i33*c1*c3*s1*s3*i12*i22*c2+s2*i13*i21*i33*c1*c3*s1*s3-s2*i13*i21*i33*c1*c3*s1*s3*i32*c2+s2*i12*i21*i22*i32*i33*c1*c2*c3*s1*s3-s1*s2*i11*i22*i23*i33*c1*s3*c2*c3+s1*s2*i11*i22*i23*i33*c1*s3*i31*c2*c3+s1*s2*i11*i22*i23*i33*c1*s3*i32*c2*c3+s1*s2*i11*i22*i23*i33*c1*s3*i21*c2*c3-s1*s2*i11*i22*i23*i33*c1*s3*i21*i32*c2*c3+s1*s2*i11*i22*i23*i33*c1*s3*i13*c2*c3-s1*s2*i11*i22*i23*i33*c1*s3*i13*i32*c2*c3-s2*i11*i12*i13*i22*i23*c2*c3*s1*i21*c1-s2*i11*i12*i13*i22*i23*c2*c3*s1*s3*i32*c1+s2*i11*i12*i13*i22*i23*c2*c3*s1*c1-s2*i11*i12*i13*i22*i23*c2*c3*s1*s3*i31*c1-s1*s3*i12*i31*c1*c2-s1*s3*i12*i31*c1*c2*i11*i33*c3-s1*s3*i12*i31*c1*c2*i11*i13*c3-s1*s3*i12*i31*c1*c2*i13*i33*c3-s1*s3*i12*i31*c1*c2*i32*i33*c3+s1*s3*i12*i31*c1*c2*s2*i23*c3-s1*s3*i12*i31*c1*c2*s2*i11*i22-s1*s3*i12*i31*c1*c2*s2*i22*i32+s1*s3*i12*i31*c1*c2*i33*c3-s1*s3*i12*i31*c1*c2*s2*i22*i33*c3-s1*s3*i12*i31*c1*c2*s2*i23*i33*c3-s1*s3*i12*i31*c1*c2*s2*i22*i23*c3+s1*s3*i12*i31*c1*c2*s2*i11*i22*i32+s1*s3*i12*i31*c1*c2*s2*i11*i23*i33*c3+s1*s3*i12*i31*c1*c2*s2*i22*i23*i33*c3+s1*s3*i12*i31*c1*c2*s2*i11*i22*i23*c3+s1*s3*i12*i31*c1*c2*s2*i11*i22*i33*c3-s1*s3*i12*i31*c1*c2*i11*i32-s1*s3*i12*i31*c1*c2*s2*i11*i23*c3+s1*s3*i12*i31*c1*c2*i13*c3+s1*s3*i12*i31*c1*c2*i11*i13*i33*c3+s1*s3*i12*i31*c1*c2*i11*i32*i33*c3+s1*s3*i12*i31*c1*c2*s2*i22-s1*s3*i12*i31*c1*c2*s2*i23*i32*c3-s1*s3*i12*i31*c1*c2*s2*i13*i23*c3-s1*s3*i12*i31*c1*c2*s2*i13*i22*c3+s1*s3*i12*i31*c1*c2*s2*i11*i13*i22*c3+s1*s3*i12*i31*c1*c2*s2*i11*i13*i23*c3+s1*s3*i12*i31*c1*c2*s2*i13*i22*i23*c3+s1*s3*i12*i31*c1*c2*s2*i11*i23*i32*c3+s1*s3*i12*i31*c1*c2*s2*i22*i32*i33*c3+s1*s3*i12*i31*c1*c2*s2*i23*i32*i33*c3-s1*s3*i12*i31*c1*c2*s2*i11*i22*i32*i33*c3-s1*s3*i12*i31*c1*c2*s2*i11*i23*i32*i33*c3+s1*s3*i12*i31*c1*c2*i11-s3*i31*i33*c1*c3-s2*s3*i23*i32*c2*c3+s2*s3*i23*i32*i33*c2*c3-s1*i11*i13*c1*c3-s2*s3*i12*i23*i32*c2*s1*i22*c3-s2*s3*i12*i23*i32*c2*s1*i33*c3-s2*s3*i12*i23*i32*c2*s1*i13*c3+s2*s3*i12*i23*i32*c2*s1*c3-s2*s3*i12*i23*i32*c2*s1*i11*i13*i33*c1*c3+s2*s3*i12*i23*i32*c2*s1*i22*i33*c3-s2*s3*i12*i23*i32*c2*s1*i13*i22*i33*c3+s2*s3*i12*i23*i32*c2*s1*i13*i22*c3+s2*s3*i12*i23*i32*c2*s1*i13*i33*c3-s2*s3*i12*i23*i32*c2*s1*i11*c1*c3-s2*s3*i12*i23*i32*c2*s1*i21*c1*c3+s2*s3*i12*i23*i32*c2*s1*i11*i22*c1*c3+s2*s3*i12*i23*i32*c2*s1*i11*i13*c1*c3+s2*s3*i12*i23*i32*c2*s1*i11*i33*c1*c3+s2*s3*i12*i23*i32*c2*s1*i21*i22*c1*c3-s2*s3*i22*i32*c2+s1*i11*i12*i13*i21*i22*c2*c3*s2*c1+s2*i12*i22*i32*i33*c1*c2*c3*s1*s3*i11-s1*s3*i11*i31*c1+s2*i12*i13*i22*i23*c2*c3*s1*s3*i33+s2*i12*i13*i22*i23*c2*c3*s1*i21*c1-s2*i12*i13*i22*i23*c2*c3*s1-s1*s2*i13*i21*c1*i11*i23*c3+s1*s2*i13*i21*c1*i22*c2*c3+s1*s2*i13*i21*c1*i12*c2*c3+s1*s2*i13*i21*c1*i11*c3+s1*s2*i13*i21*c1*i23*c3+s1*s2*i13*i21*c1*i11*i12*i23*c2*c3-s1*s2*i13*i21*c1*s3*i22*i32*c2*c3-s1*s2*i13*i21*c1*i11*i22*c2*c3-s1*s2*i13*i21*c1*i22*i23*c2*c3+s1*s2*i13*i21*c1*i11*i22*i23*c2*c3-s1*s2*i13*i21*c1*i12*i22*c2*c3-s1*s2*i13*i21*c1*i11*i12*c2*c3+s1*s2*i13*i21*c1*s3*i32*c2*c3-s1*s2*i13*i21*c1*i12*i23*c2*c3+s1*s2*i13*i21*c1*s3*i11*i22*i32*c2*c3-s1*s2*i13*i21*c1*s3*i11*i32*c2*c3-s2*i21*i22*c1*c2-s1*i13*i31*i32*i33*c3*s3*c1*c2+s1*i13*i31*i32*i33*c3*s3*i11*c1*c2+s1*i13*i31*i32*i33*c3*s2*s3*i22*c1*c2-s1*i13*i31*i32*i33*c3*s2*s3*i11*i22*c1*c2+s1*i11*i21*i23*i32*c1*c2*c3*s2*s3*i33+s1*i11*i21*i23*i32*c1*c2*c3*s2*s3*i22-s1*i11*i21*i23*i32*c1*c2*c3*s2*s3-s2*i22*i23*c2*c3+s2*i13*i22*i23*i32*c2*c3*s1*s3*i33+s2*i13*i22*i23*i32*c2*c3*s1*s3*i11*c1-s2*i13*i22*i23*i32*c2*c3*s1*s3+s1*s2*i12*c2*i11*i22*c1+s1*s2*i12*c2*s3*i22*i32+s1*s2*i12*c2*i22*i23*c3+s1*s2*i12*c2*i13*i22*c3+s1*s2*i12*c2*i13*i23*c3+s1*s2*i12*c2*i11*i21*c1+s1*s2*i12*c2*i21*i22*c1-s1*s2*i12*c2*i23*c3+s1*s2*i12*c2*s3*i11*i21*i22*i32*c1-s1*s2*i12*c2*i21*c1+s1*s2*i12*c2*s3*i21*i32*c1-s1*s2*i12*c2*s3*i11*i21*i32*c1+s1*s2*i12*c2*s3*i23*i33*c3+s1*s2*i12*c2*s3*i22*i33*c3+s1*s2*i12*c2*s3*i13*i22*i32*i33*c3-s1*s2*i12*c2*s3*i22*i32*i33*c3-s1*s2*i12*c2*s3*i13*i23*i33*c3-s1*s2*i12*c2*s3*i13*i22*i33*c3-s1*s2*i12*c2*s3*i13*i22*i32*c3-s1*s2*i12*c2*s3*i22*i23*i33*c3-s1*s2*i12*c2*s3*i11*i22*i33*c1*c3-s1*s2*i12*c2*i11*i21*i22*c1-s1*s2*i12*c2*i11*i13*i22*c1*c3-s1*s2*i12*c2*s3*i11*i22*i32*c1+s1*s2*i12*c2*s3*i11*i13*i22*i32*c1*c3+s1*s2*i12*c2*i21*i23*c1*c3+s1*s2*i12*c2*i11*i23*c1*c3-s1*s2*i12*c2*s3*i21*i22*i32*c1-s1*s2*i12*c2*s3*i11*i23*i33*c1*c3-s1*s2*i12*c2*i11*i21*i23*c1*c3+s1*s2*i12*c2*s3*i11*i13*i22*i33*c1*c3+s1*s2*i12*c2*s3*i21*i33*c1*c3-s1*s2*i12*c2*s3*i21*i32*i33*c1*c3-s1*s2*i12*c2*s3*i11*i21*i33*c1*c3+s1*s2*i12*c2*s3*i11*i21*i32*i33*c1*c3-s1*s2*i12*c2*i11*i22*i23*c1*c3-s1*s2*i12*c2*i21*i22*i23*c1*c3+s1*s2*i12*c2*i11*i21*i22*i23*c1*c3-s1*s2*i12*c2*i11*i13*i23*c1*c3-s1*s2*i12*c2*s3*i21*i22*i33*c1*c3+s1*s2*i12*c2*s3*i11*i13*i23*i33*c1*c3+s1*s3*i11*i13*i31*c1*c3-s1*s3*i11*i33*c1*c3+s1*s3*i11*i31*i33*c1*c3-s1*s3*i11*i13*i31*i33*c1*c3+s1*s3*i13*i31*i33*c1*c3+s1*s3*i11*i13*i33*c1*c3+s2*s3*i13*i23*i32*i33*c1*c2*s1*i11*c3+s1*s3*i23*i32*i33*c1*c2*c3*s2*i11*i31-s1*s3*i23*i32*i33*c1*c2*c3*s2*i11-s2*s3*i22*i33*c2*c3-s1*i11*i13*i31*i32*c1*s3*c2*c3+s1*i11*i13*i31*i32*c1*s2*s3*i23*c2*c3+s1*i11*i13*i31*i32*c1*s2*s3*i22*c2*c3+s2*i22*i23*i32*i33*c1*c2*s3*i31*c3+s2*i22*i23*i32*i33*c1*c2*s3*i21*c3-s1*s2*i13*i22*i31*i33*c2*s3*c1*c3+s1*s2*i13*i22*i31*i33*c2*s3*i11*c1*c3+s2*s3*i11*i31*i32*i33*c3*s1*i22*c1*c2+s1*s2*i11*i23*i32*c3*s3*c1*c2-s1*s2*i11*i23*i32*c3*s3*i22*c1*c2-s1*s2*i11*i23*i32*c3*s3*i31*c1*c2-s1*s2*i11*i23*i32*c3*s3*i13*c1*c2-s1*i11*i22*i32*c1*c2*c3*s2*s3*i33-s1*i11*i22*i32*c1*c2*c3*s2*s3*i13+s1*i11*i22*i32*c1*c2*c3*s2*s3*i21*i33+s1*i11*i22*i32*c1*c2*c3*s2*s3*i13*i33+s2*i23*c1*c2*c3*s1*i11*i22+s2*i23*c1*c2*c3*s3*i22*i31+s2*i23*c1*c2*c3*s3*i21*i32+s2*i23*c1*c2*c3*s3*i31*i32-s2*i23*c1*c2*c3*s3*i22*i31*i33-s2*i23*c1*c2*c3*s3*i21*i22*i33-s2*i23*c1*c2*c3*s1*i11*i21*i22+s2*i23*c1*c2*c3*i21*i22-s2*i23*c1*c2*c3*s3*i22*i31*i32+s2*i23*c1*c2*c3*s1*s3*i11*i13*i22*i31-s2*i23*c1*c2*c3*s1*s3*i13*i31*i32-s2*i23*c1*c2*c3*s1*s3*i11*i22*i31-s2*i23*c1*c2*c3*s1*i11*i13*i22-s2*i23*c1*c2*c3*s1*s3*i13*i22*i31-s2*i23*c1*c2*c3*s3*i21*i32*i33-s2*i23*c1*c2*c3*s3*i31*i32*i33-s2*i23*c1*c2*c3*s3*i21*i22*i32-s3*i31*i32*c1*c2+s1*i11*i12*i13*i32*c1*c3*s3*i33*c2-s1*i11*i12*i13*i32*c1*c3*s3*c2-s1*i12*i32*i33*c1*c2*c3*s3*i11-s2*i11*i13*i22*i33*c1*c2*c3*s1*s3-s2*i21*i23*c1*c3-s1*s2*i11*i21*c1-s1*s3*i13*i32*c2*c3-s1*i12*i13*c2*c3+s1*s3*i12*i13*i32*c2*c3+s2*i21*i33*c1*s3*i23*c3+s2*i21*i33*c1*s3*i31*c3-s2*i21*i33*c1*s3*c3-s2*i21*i33*c1*s3*i22*i32*c2*c3+s2*i21*i33*c1*s3*i22*c2*c3-s2*i21*i33*c1*s3*i23*i31*c3-s2*i21*i33*c1*s1*s3*i11*i22*c2*c3+s2*i21*i33*c1*s3*i32*c2*c3+s2*i21*i33*c1*s1*s3*i11*c3-s2*i21*i33*c1*s1*s3*i11*i23*c3-s2*i21*i33*c1*s1*s3*i11*i32*c2*c3+s2*i11*i23*i31*c3*s1*s3*c1-s2*i11*i23*i31*c3*s1*s3*i33*c1-s2*i11*i23*i31*c3*s1*s3*i13*c1+s2*i11*i23*i31*c3*s1*s3*i13*i33*c1-s2*i13*i22*i31*i32*c2*s1*s3*c1*c3+s2*s3*i22*i31*i32*c1*c2-s2*s3*i21*i31*c1-s2*s3*i21*i32*c1*c2-s1*i11*i21*i32*c1*c2*s2*s3*i22+s1*i11*i21*i32*c1*c2*s2*s3-s1*s2*i13*i23*c3+s1*s2*i13*i22*i23*c2*c3-s1*s2*i13*i22*c2*c3+s1*s2*i11*i13*i22*c1*c2*c3-s1*s2*i11*i13*i22*c1*c2*c3*s3*i31-s3*i11*i22*i31*i32*c1*s1*s2*c2-s2*i11*i22*i31*i33*c2*s1*s3*c1*c3+s2*i11*i22*i33*c1*c2*c3*s1*s3+s1*s2*i13*i22*c1*c2*c3*s3*i31+s1*s3*i13*i32*i33*c2*c3+s1*s3*i12*i32*i33*c2*c3-s1*s3*i12*i33*c2*c3-s1*s3*i12*i13*i32*i33*c2*c3+s1*s3*i12*i13*i33*c2*c3+s1*i13*i22*i33*c3*s2*s3*c2-s1*i13*i22*i33*c3*s2*s3*i23*c2-s1*i13*i22*i33*c3*s2*s3*i32*c2+s3*i12*i32*c1*c2*s1*i11-s3*i22*i32*i33*c1*c2*c3*s2*i31-s1*i11*i12*i13*c2*c3*s3*i33*c1+s1*i11*i12*i13*c2*c3*c1+s2*s3*i22*i23*i32*c2*c3+s1*i11*i12*i33*c1*s3*c2*c3+s2*i21*i22*c1*s1*i11*c2+s2*i21*i22*c1*s3*i32*c2+s2*i22*i31*i33*c1*c2*s3*c3-s1*s3*i13*i32*i33*c1*c2*i11*c3+s1*i11*i13*i32*c1*s3*c2*c3-s1*s3*i11*i32*c1*c2+s1*s3*i11*i31*i32*c1*c2-s2*i22*i23*i33*c3*s3*i32*c2-s1*s2*i11*i22*c1*c2-s2*i23*i32*c3*s1*s3*i13*i33*c2+s2*i23*i32*c3*s1*s3*i13*c2-s2*i11*i13*i23*i33*c1*c3*s1*s3+s2*i23*i33*c1*c3*s3*i31+s2*i23*i33*c1*c3*s1*s3*i11-s2*i23*i33*c1*c3*s1*s3*i13*i31+s3*i31*i32*i33*c1*c2*c3-s3*i31*i32*i33*c1*s1*i11*c2*c3+s1*i11*i32*i33*c1*c2*s3*c3+s2*s3*i22*i32*i33*c2*c3+s1*i13*i31*c1*c3*s3*i32*c2+s1*i13*i31*c1*c3*s2*s3*i23+s1*i13*c1*c3*s2*i11*i23+s2*i13*i22*i32*c2*s1*s3*c3-s2*s3*i23*i31*c1*c3+s1*s3*i11*i22*c1*s2*i31*c2+s1*s3*i11*i22*c1*s2*i32*c2-s1*s2*i11*i23*c1*c3+s2*s3*i13*i23*i33*c3*s1+s2*s3*i21*i23*i31*c1*c3;
return