%% compute_arm_metrics.m
function [supp,conf1,conf2,lift,driving,inter,IG] = compute_arm_metrics1(dataset,feat, G)
    % This function takes a dataset of binary features of which G is the
    % goodness feature and computes support (F), confidence (F-> G), conf (G ->
    % F) and lift (F & G) for all features in the dataset
    [N,~] = size(dataset);
    suppG = sum(dataset.(G) == 1)/N;
    PG = [suppG 1-suppG];
    HG = shannon_entropy(PG);

    supp = sum(feat.Values == 1)/N;
    if supp == 0
        conf1 = 0;
        conf2 = 0;
        lift = 0;
        driving = false;
        inter = 0;
        IG = 0;
        return;
    end
    conf1 = sum(feat.Values == 1 & dataset.(G) == 1)/N/supp;
    conf2 = conf1*supp/suppG;
    lift = conf1/suppG;
    PF = [supp 1-supp];
%     PFG = [sum(feat.Values == 0 & dataset.(G) == 0) sum(feat.Values == 0 & dataset.(G) == 1) sum(feat.Values == 1 & dataset.(G) == 0) sum(feat.Values == 1 & dataset.(G) == 1)]./N;
    PC_F0 = ([sum(feat.Values == 0 & dataset.(G) == 0) sum(feat.Values == 1 & dataset.(G) == 0)]./N) ./ (1-supp);
    PC_F1 = ([sum(feat.Values == 0 & dataset.(G) == 1) sum(feat.Values == 1 & dataset.(G) == 1)]./N) ./ (supp);
%     HC_X = -(PFG(1)*log2(PC_F0(1)) + PFG(2)*log2(PC_F0(2)) + PFG(3)*log2(PC_F1(1)) + PFG(4)*log2(PC_F1(2)));
    HC_X = -(PF(1)*( PC_F0(1)*log2(PC_F0(1)) + PC_F0(2)*log2(PC_F0(2)) ) + PF(2)*( PC_F1(1)*log2(PC_F1(1)) + PC_F1(2)*log2(PC_F1(2)) ));
    IG = HG - HC_X; 
    
    %     inter = lift*sum([conf1,conf2]);
%     inter = lift*min([conf1,conf2]);
%     inter = IG*min([conf1,conf2]);
    inter = min([conf1,conf2]);
        
%     inter = conf2;
    driving = (conf1 > 0.9 & conf2> 0.9 & lift > 1);
end


    