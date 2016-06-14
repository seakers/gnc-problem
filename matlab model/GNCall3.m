% script GNCall3: Test with NS=NC=2, and only two types of components.
vec_Robj = [0.999 0.9999 0.99999 0.999999 0.9999999 0.99999999 0.999999999];

%% Simulation 1 : CW = 0, DCP = 0, Rijk = 1
gnc = GNC_init();
gnc.NSMAX = 3;
gnc.NCMAX = 3;
gnc.DissimilarComponentPenalty = 0;
gnc.M_I0 = 0;
gnc.R_I0 = 1;

gncs = GNC_enumerate_2types(gnc);
gncs = GNC_evaluate(gncs);

[R,m] = GNC_plot(gncs,'R','m','lin');
%ind(i) = GNC_find_opt(gncs,Robj);
Rlim = gncs(29).R;
gncs_out = GNC_find_gncs(gncs,Rlim);
[front,CS,NS,NC,NH] = GNC_paretofront(gncs);
[front2,CS2,NS2,NC2,NH2] = GNC_paretofront(gncs_out);
NS2
NC2
%[front2,CS2,NS2,NC2,NH2] = GNC_paretofront2(gncs,vec_Robj);
%save 2x2scenario1
