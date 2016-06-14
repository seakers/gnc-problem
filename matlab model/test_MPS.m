% test_MPS.m
% This script tests the GNC_MPS algorithm against FastRelCalc

R1 = zeros(100,1);
R2 = zeros(100,1);

for i = 1:100
    fprintf('i = %d\n',i);
    Rs = [rand rand rand];
    Rc = [rand rand rand];
    Ijk = [rand rand rand;rand rand rand;rand rand rand];
    R1(i) = GNC_MPS(Rs,Rc,Ijk);
    R2(i) = FastRelCalc_new(Rs,Rc,Ijk);
    R3(i) = CalcReliability_new(Rs,Rc,Ijk);
end

plot(R2,R3,'.');

