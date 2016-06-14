%% get_dataset.m

% dataset = struct2table(gncs);
[minNSNC,vec_R, N9, vec_m, fcs, homo, front, NS, NC, NI, C1, C2, C3, C, G, NSA, NSB, NSC, NCA, NCB, NCC] = compute_advanced_features(gncs);
dataset = table();
% design variables
