function rel = FastRelCalc(Rs,Rc,Ijk)
% FastRelCalc.m
% Quickly calculates the reliability of a 3x2 GNC system given the
% reliabilities of the sensors, computers and interconnections and the way
% elements are connected.
% Usage:
% rel = FastRelCalc(Rs,Rc,Ijk);
% Inputs:
% Rs = [0.99 0.99 0.9996]'; % Reliabilities of the three sensors of the
% architecture (different of the reliabilities of the three different
% types!) or zero if absent.
% Rc = [0.999 0.9996 0.999]'; % Reliabilities of the three computers of the
% architecture or zero if absent.
% Ijk = 0.99995.*[1 1 1;1 0 1;0 1 1]; % Reliability of each interconnection
% or zero if not connected.
% Reliability is calculated by applying an expression which was found using
% CalcReliability.m with a symbolic 3x2 cross-strapped architecture.
% Absent elements have zero reliability thus giving a correct result.

% s1 = sym('s1');
% s2 = sym('s2');
% s3 = sym('s3');
% c1 = sym('c1');
% c2 = sym('c2');
% c3 = sym('c3');
% 
% i11 = sym('i11');
% i12 = sym('i12');
% i13 = sym('i13');
% i21 = sym('i21');
% i22 = sym('i22');
% i23 = sym('i23');
% i31 = sym('i31');
% i32 = sym('i32');
% i33 = sym('i33');
% 
% tmp = sym(s1*i11*c1+s1*i12*c2+s1*i13*c3-i11*c1*s1*i12*c2-(i11*c1+i12*c2-i11*c1*i12*c2)*s1*i13*c3+...
% s2*i21*c1+s2*i22*c2+s2*i23*c3-i21*c1*s2*i22*c2-(i21*c1+i22*c2-i21*c1*i22*c2)*s2*i23*c3+s3*i31*c1+...
% s3*i32*c2+s3*i33*c3-i31*c1*s3*i32*c2-(i31*c1+i32*c2-i31*c1*i32*c2)*s3*i33*c3-...
% (s1*i11+s1*i12+s1*i13-i11*s1*i12-(i11+i12-i11*i12)*s1*i13)*(s2*i21*c1+s2*i22*c2+s2*i23*c3-...
% i21*c1*s2*i22*c2-(i21*c1+i22*c2-i21*c1*i22*c2)*s2*i23*c3)-(s1*i11+s1*i12+s1*i13-i11*s1*i12-...
% (i11+i12-i11*i12)*s1*i13+s2*i21+s2*i22+s2*i23-i21*s2*i22-(i21+i22-i21*i22)*s2*i23-...
% (s1*i11+s1*i12+s1*i13-i11*s1*i12-(i11+i12-i11*i12)*s1*i13)*(s2*i21+s2*i22+s2*i23-i21*s2*i22-...
% (i21+i22-i21*i22)*s2*i23))*(s3*i31*c1+s3*i32*c2+s3*i33*c3-i31*c1*s3*i32*c2-(i31*c1+i32*c2-i31*c1*i32*c2)*s3*i33*c3));

s1 = Rs(1);
s2 = Rs(2);
s3 = Rs(3);
c1 = Rc(1);
c2 = Rc(2);
c3 = Rc(3);
i11 = Ijk(1,1);
i12 = Ijk(1,2);
i13 = Ijk(1,3);
i21 = Ijk(2,1);
i22 = Ijk(2,2);
i23 = Ijk(2,3);
i31 = Ijk(3,1);
i32 = Ijk(3,2);
i33 = Ijk(3,3);

% rel = eval(tmp);


rel = s1*i11*c1+s1*i12*c2+s1*i13*c3-i11*c1*s1*i12*c2-(i11*c1+i12*c2-i11*c1*i12*c2)*s1*i13*c3+s2*i21*c1+s2*i22*c2+s2*i23*c3-i21*c1*s2*i22*c2-(i21*c1+i22*c2-i21*c1*i22*c2)*s2*i23*c3+s3*i31*c1+s3*i32*c2+s3*i33*c3-i31*c1*s3*i32*c2-(i31*c1+i32*c2-i31*c1*i32*c2)*s3*i33*c3-(s1*i11+s1*i12+s1*i13-i11*s1*i12-(i11+i12-i11*i12)*s1*i13)*(s2*i21*c1+s2*i22*c2+s2*i23*c3-i21*c1*s2*i22*c2-(i21*c1+i22*c2-i21*c1*i22*c2)*s2*i23*c3)-(s1*i11+s1*i12+s1*i13-i11*s1*i12-(i11+i12-i11*i12)*s1*i13+s2*i21+s2*i22+s2*i23-i21*s2*i22-(i21+i22-i21*i22)*s2*i23-(s1*i11+s1*i12+s1*i13-i11*s1*i12-(i11+i12-i11*i12)*s1*i13)*(s2*i21+s2*i22+s2*i23-i21*s2*i22-(i21+i22-i21*i22)*s2*i23))*(s3*i31*c1+s3*i32*c2+s3*i33*c3-i31*c1*s3*i32*c2-(i31*c1+i32*c2-i31*c1*i32*c2)*s3*i33*c3);
% rel2 = s1*i11*c1+s2*i22*c2+s3*i33*c3-s1*i11*c1*s2*i22*c2-(s1*i11*c1+s2*i22*c2-s1*i11*c1*s2*i22*c2)*s3*i33*c3;
return