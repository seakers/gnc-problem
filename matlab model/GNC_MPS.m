function rel = GNC_MPS(Rs,Rc,Ijk)
% GNC_MPS.m
% Quickly calculates the reliability of a 3x2 GNC system given the
% reliabilities of the sensors, computers and interconnections and the way
% elements are connected using the minimal path sets algorithm.
% Usage:
% rel = GNC_MPS(Rs,Rc,Ijk);
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

rel = 1 - (1-s1*i11*c1)*(1-s1*i12*c2)*(1-s1*i13*c3)*(1-s2*i21*c1)*(1-s2*i22*c2)*(1-s2*i23*c3)*(1-s3*i31*c1)*(1-s3*i32*c2)*(1-s3*i33*c3);
return