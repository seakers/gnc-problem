%% GNCscript9
% Plots Rlim as a function of R(SA) = R(CA) for several different
% architectures : 2x2/3x3 channelized/cross-strapped.

%% Inputs
N_9_comp = [2:1:7];
N_9_conn = 4;

%% Intermediate parameters
R_comp = 1-10.^(-N_9_comp);
Rijk = 1-10.^(-N_9_conn);

n = 1;
I(:,:,n) = Rijk.*[1 0 0;0 1 0;0 0 0]; % 2x2 channelized



n = n + 1;
I(:,:,n) = Rijk.*[1 1 0; 1 1 0;0 0 0]; % 2x2 cross-strapped

n = n + 1;
I(:,:,n) = Rijk.*[1 0 0; 1 1 0;0 1 0]; % 3x2 hybrid

n = n + 1;
I(:,:,n) = Rijk.*[1 1 0; 1 1 0;1 1 0]; % 3x2 cross-strapped

n = n + 1;
I(:,:,n) = Rijk.*[1 1 0; 0 1 1;0 0 0]; % 2x3 hybrid

n = n + 1;
I(:,:,n) = Rijk.*[1 1 1; 1 1 1;0 0 0]; % 2x3 cross-strapped

n = n + 1;
I(:,:,n) = Rijk.*[1 0 0; 0 1 0;0 0 1]; % 3x3 channelized

n = n + 1;
I(:,:,n) = Rijk.*[1 1 1; 1 1 1;1 1 1]; % 3x3 cross-strapped

J = I;

%% Calculations
lon1 = length(R_comp);
lon2 = size(I,3);
rel = zeros(lon1,lon2); % Each row of rel has the reliabilities for the ...
% ... different architectures for one value of R_component

for i = 1:lon1
    Rs = R_comp(i).*[1 1 1]';
    Rc = Rs;
    for j = 1:lon2
        %rel(i,j) = FastRelCalc_new(Rs,Rc,I(:,:,j));
        fprintf('Iteration %d from %d\n',(i-1)*lon2+j,lon1*lon2);
        rel(i,j) = CalcReliability_new(Rs,Rc,I(:,:,j));
    end
end
N_9_Rlim = -log10(1-rel);
slope_rel = diff(N_9_Rlim);
vec_tmp = zeros(lon1-1,1);
for k = 1:lon1-1
    vec_tmp(k) = (N_9_comp(k)+N_9_comp(k+1))/2; 
end
%% Plot 1
plot(N_9_comp,N_9_Rlim);
xlabel({'# of 9''s of R_{comp}'},'FontSize',18,'FontName','Agency FB');
ylabel({'# of 9''s of R_{lim}'},'FontSize',18,'FontName','Agency FB');
title({'R_{lim} (max achievable reliability with like components) as a function of R_{comp} (reliability of the components)'},...
    'FontSize',18,...
    'FontName','Agency FB');
legend1 = legend('2x2 channelized','2x2 cross-strapped','3x2 hybrid', '3x2 cross-strapped', '2x3 hybrid', '2x3 cross-strapped', '3x3 channelized','3x3 cross-strapped');
set(legend1,'FontSize',14,'FontName','Agency FB');

%% Plot 2
figure;
plot(vec_tmp,slope_rel);
xlabel({'# of 9''s of R_{comp}'},'FontSize',18,'FontName','Agency FB');
ylabel({'slope of # of 9''s of R_{lim}'},'FontSize',18,'FontName','Agency FB');
title({'Slope of # of 9''s in as a function of # of 9''s in R_{comp} '},...
    'FontSize',18,...
    'FontName','Agency FB');
legend2 = legend('2x2 channelized','2x2 cross-strapped','3x2 hybrid', '3x2 cross-strapped', '2x3 hybrid', '2x3 cross-strapped', '3x3 channelized','3x3 cross-strapped');
set(legend2,'FontSize',14,'FontName','Agency FB');

%% End of GNCscript9