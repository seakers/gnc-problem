N = 1000;
Rc = zeros(N,1);
R1 = zeros(N,1);
R2 = zeros(N,1);
n9 = zeros(N,1);
for i = 1:N
    n9(i) = 10*rand;
    Rc(i) = (1-10.^(-n9(i)));
    Rcomp = Rc(i).*[1 1 1]';
    R1(i) = CalcReliability_new(Rcomp,Rcomp,[1 1 1;1 1 1;1 1 1]);
    R2(i) = FastRelCalc_new(Rcomp,Rcomp,[1 1 1;1 1 1;1 1 1]);
    %out(i) = -log10(1-R(i));
    if R2(i) > 1
        fprintf('for n9 = %d R = %f.\n',n9(i),R2(i));
    end
end
dR = R2 - R1;
plot(n9,dR,'b.');
fprintf('The mean of dR is %f and the std average is %f.\n',mean(dR),std(dR));