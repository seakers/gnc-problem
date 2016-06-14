R_ref = gncs(2666).R;
n9 = -log10(1-R_ref);
m_ref = gncs(2666).m;
CW = 0.5;
Nlinks_ref = 3;
delta_R = zeros(2770-2649,1);
delta_m = zeros(2770-2649,1);
for i =2650:2770
    delta_R(i-2649) = gncs(i).R - R_ref;
    delta_m(i-2649) = 3/5.*(gncs(i).m - m_ref);
end

plot(10^(fix(n9)).*delta_R,delta_m,'bx');
xlabel('R-R_{channelized} amplified to see the first digit that is not a 9','FontSize',14,'FontName','Arial');
ylabel('m-m_{channelized}','FontSize',14,'FontName','Arial');
title('Benefit in R and cost in m obtained out of adding links to a 3x3 channelized architecture of like components','FontSize',16,'FontName','Arial')      