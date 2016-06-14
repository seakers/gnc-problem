ri = [1 0.99999999 0.9999999 0.999999 0.99999 0.9999 0.999 0.99 0.9 0.8 0.7];
R = zeros(length(ri),5);
U = zeros(length(ri),5);
for i = 1:length(ri)
    R(i,1) = CalcReliability_new(0.9985.*ones(3,1),0.999.*ones(3,1),ri(i).*[1 0 0;0 0 0;0 0 0]);
    R(i,2) = CalcReliability_new(0.9985.*ones(3,1),0.999.*ones(3,1),ri(i).*[1 0 0;0 1 0;0 0 0]);
    R(i,3) = CalcReliability_new(0.9985.*ones(3,1),0.999.*ones(3,1),ri(i).*[1 1 0;1 1 0;0 0 0]);
    R(i,4) = CalcReliability_new(0.9985.*ones(3,1),0.999.*ones(3,1),ri(i).*[1 0 0;0 1 0;0 0 1]);
    R(i,5) = CalcReliability_new(0.9985.*ones(3,1),0.999.*ones(3,1),ri(i).*ones(3));
    U(i,1) = -log10(1-R(i,1));
    U(i,2) = -log10(1-R(i,2));
    U(i,3) = -log10(1-R(i,3));
    U(i,4) = -log10(1-R(i,4));
    U(i,5) = -log10(1-R(i,5));
end
