% script GNCall2
% %vec_Robj = [0.999 0.9999 0.99999 0.999999 0.9999999 0.99999999 0.999999999];
%% Simulation 1 : CW = 0, DCP = 0, Rijk = 1
% gnc = GNC_init();
% 
% gnc.DissimilarComponentPenalty = 0;
% gnc.M_I0 = 0;
% gnc.R_I0 = 1;
% 
% gncs = GNC_enumerate(gnc);
% gncs = GNC_evaluate(gncs);

% GNC_plot(gncs,'R','m','lin');
%ind(i) = GNC_find_opt(gncs,Robj);

% [front,CS,NS,NC,NH] = GNC_paretofront(gncs);
%load scenario1_new
Narc  = length(gncs);
for i = 1:Narc
    R = gncs(i).R;
    N9 = -log10(1-R);
    gncs(i).N9 = N9;
end
% [front2,CS2,NS2,NC2,NH2] = GNC_paretofront2(gncs,vec_Robj);
save scenario1_new

%% Simulation 3 : CW = 0, DCP = 9, Rijk = 1
% gnc = GNC_init();
% 
% gnc.DissimilarComponentPenalty = 9;
% gnc.M_I0 = 0;
% gnc.R_I0 = 1;
% 
% gncs = GNC_enumerate(gnc);
% gncs = GNC_evaluate(gncs);
% 
% GNC_plot(gncs,'R','m','lin');
%ind(i) = GNC_find_opt(gncs,Robj);
% [front,CS,NS,NC,NH] = GNC_paretofront(gncs); % Algorithm 1, fix m and max R.
% [front2,CS2,NS2,NC2,NH2] = GNC_paretofront2(gncs,vec_Robj); % Algorithm 2, fix R and min m.
load scenario3_new
Narc  = length(gncs);
for i = 1:Narc
    R = gncs(i).R;
    N9 = -log10(1-R);
    gncs(i).N9 = N9;
end
save scenario3_new

%% Simulation 7 : CW = 5/3, DCP = 0, Rijk = 1
% gnc = GNC_init();
% 
% gnc.DissimilarComponentPenalty = 0;
% gnc.M_I0 = 5/3;
% gnc.R_I0 = 1;
% 
% gncs = GNC_enumerate(gnc);
% gncs = GNC_evaluate(gncs);

% GNC_plot(gncs,'R','m','lin');
%ind(i) = GNC_find_opt(gncs,Robj);
% [front,CS,NS,NC,NH] = GNC_paretofront(gncs); % Algorithm 1, fix m and max R.
% [front2,CS2,NS2,NC2,NH2] = GNC_paretofront2(gncs,vec_Robj); % Algorithm 2, fix R and min m.
load scenario7_new
Narc  = length(gncs);
for i = 1:Narc
    R = gncs(i).R;
    N9 = -log10(1-R);
    gncs(i).N9 = N9;
end
save scenario7_new

%% Simulation 9 : CW = 5/3, DCP = 9, Rijk = 1
% gnc = GNC_init();
% 
% gnc.DissimilarComponentPenalty = 9;
% gnc.M_I0 = 5/3;
% gnc.R_I0 = 1;
% 
% gncs = GNC_enumerate(gnc);
% gncs = GNC_evaluate(gncs);

% GNC_plot(gncs,'R','m','lin');
%ind(i) = GNC_find_opt(gncs,Robj);
% [front,CS,NS,NC,NH] = GNC_paretofront(gncs); % Algorithm 1, fix m and max R.
% [front2,CS2,NS2,NC2,NH2] = GNC_paretofront2(gncs,vec_Robj); % Algorithm 2, fix R and min m.
load scenario9_new
Narc  = length(gncs);
for i = 1:Narc
    R = gncs(i).R;
    N9 = -log10(1-R);
    gncs(i).N9 = N9;
end
save scenario9_new

