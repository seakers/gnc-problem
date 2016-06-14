function [GNC_out] = ScaleMass(GNC,mode)
global SENSORS COMPUTERS ACTUATORS INTERCONNECTIONS M_SENS M_COMP M_ACTU R_SA R_SB R_SC R_CA R_CB R_CC R_AA R_AB R_AC

if strcmp(mode,'scale')
    M_S0 = GNC.M_S0;
    R_S0 = GNC.R_S0;
    M_C0 = GNC.M_C0;
    R_C0 = GNC.R_C0;


    k1 = GNC.SensorMassScalingFactor;
    r1 = GNC.SensorMassSpacingFactor;
    alfa1 = GNC.SensorReliabScalingFactor;

    M_SA = k1*(1-r1)*M_S0;
    M_SB = k1*M_S0;
    M_SC = k1*(1+r1)*M_S0;

    kr1 = k1/alfa1;
    R_SA = 1 - (1-R_S0)/(10^(kr1*(1-r1)-1));
    R_SB = 1 - (1-R_S0)/(10^(kr1-1));
    R_SC = 1 - (1-R_S0)/(10^(kr1*(1+r1)-1));

    k2 = GNC.CompMassScalingFactor;
    r2 = GNC.CompMassSpacingFactor;
    alfa2 = GNC.CompReliabScalingFactor;

    M_CA = k2*(1-r2)*M_C0;
    M_CB = k2*M_C0;
    M_CC = k2*(1+r2)*M_C0;

    kr2 = k2/alfa2;
    R_CA = 1 - (1-R_C0)/(10^(kr2*(1-r2)-1));
    R_CB = 1 - (1-R_C0)/(10^(kr2-1));
    R_CC = 1 - (1-R_C0)/(10^(kr2*(1+r2)-1));



    SENSORS =   ['100';'200';'110';'120';'220'];
    M_SENS =    [M_SA;M_SB;2*M_SA;M_SA+M_SB;2*M_SB];
    COMPUTERS = ['100';'200';'110';'120';'220'];
    M_COMP =    [M_CA;M_CB;2*M_CA;M_CA+M_CB;2*M_CB];
    INTERCONNECTIONS = [1:3]';

    GNC_out      = GNC;
    GNC_out.M_SA = M_SA;
    GNC_out.M_SB = M_SB;
    GNC_out.M_SC = M_SC;
    GNC_out.M_CA = M_CA;
    GNC_out.M_CB = M_CB;
    GNC_out.M_CC = M_CC;

    GNC_out.R_SA = R_SA;
    GNC_out.R_SB = R_SB;
    GNC_out.R_SC = R_SC;
    GNC_out.R_CA = R_CA;
    GNC_out.R_CB = R_CB;
    GNC_out.R_CC = R_CC;
elseif strcmp(mode,'fix')
    % Values from Gregor's paper
    M_SA = 3;
    M_SB = 100;
    M_SC = 0;
    R_SA = 0.999;
    R_SB = 0.99999;
    R_SC = 0;
    M_CA = 3;
    M_CB = 3;
    M_CC = 0;
    R_CA = 0.9990;
    R_CB = 0.9990;
    R_CC = 0;
%     M_AA = 3;
%     M_AB = 6;
%     M_AC = 9;
%     R_AA = 0.9985;
%     R_AB = 0.9990;
%     R_AC = 0.9995;
    
    SENSORS =   ['100';'200';'110';'120';'220'];
    M_SENS =    [M_SA;M_SB;2*M_SA;M_SA+M_SB;2*M_SB];
    COMPUTERS = ['100';'200';'110';'120';'220'];
    M_COMP =    [M_CA;M_CB;2*M_CA;M_CA+M_CB;2*M_CB];
    INTERCONNECTIONS = [1:3]';
    
    GNC_out      = GNC;
    GNC_out.M_SA = M_SA;
    GNC_out.M_SB = M_SB;
    GNC_out.M_SC = 0;
    GNC_out.M_CA = M_CA;
    GNC_out.M_CB = M_CB;
    GNC_out.M_CC = 0;
%     GNC_out.M_AA = M_AA;
%     GNC_out.M_AB = M_AB;
%     GNC_out.M_AC = M_AC;

    GNC_out.R_SA = R_SA;
    GNC_out.R_SB = R_SB;
    GNC_out.R_SC = 0;
    GNC_out.R_CA = R_CA;
    GNC_out.R_CB = R_CB;
    GNC_out.R_CC = 0;   
%     GNC_out.R_AA = R_AA;
%     GNC_out.R_AB = R_AB;
%     GNC_out.R_AC = R_AC;

else
    fprintf('[ScaleMass.m]: Error, input argument "mode" can only be "scale" or "fix"');
end

return