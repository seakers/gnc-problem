num_sen = 3;
num_com = 3;
num_dec = num_sen*num_com;

%computer reliabilities
R_CA = 0.9990;
R_CB = 0.9996;
R_CC = 0.9998;
rc = [R_CA;R_CB;R_CC];
%computer mass
M_CA = 3;
M_CB = 5;
M_CC = 10;
mc = [M_CA;M_CB;M_CC];
%sensor reliabilities
R_SA = 0.9985;
R_SB = 0.9990;
R_SC = 0.9995;
rs = [R_SA;R_SB;R_SC];
%computer mass
M_SA = 3;
M_SB = 6;
M_SC = 9;
ms = [M_SA;M_SB;M_SC];

archs = Enum_binary_arrays(num_dec);
narchs = size(archs,1);
% rel = zeros(narchs,1);
% mass = zeros(narchs,1);
for i=386:narchs
    arch = reshape(archs(i,:),[num_sen,num_com]);
    rel(i) = CalcReliability_new(rs,rc,arch);
    m_comps = sum(mc(sum(arch,1)>0));
    m_sens = sum(ms(sum(arch,2)>0));
    mass(i) = m_comps + m_sens;
end