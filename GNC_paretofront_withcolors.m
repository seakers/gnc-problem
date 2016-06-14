function [front,CS,NS,NC,N_homogen,NSC,CS2,NSC2,N_homogen2, indexes_CS2] = GNC_paretofront_withcolors(vec_gnc)
%% GNC_paretofront.m
% Usage : [front,CS,NS,NC,N_homogen] = GNC_paretofront(vec_gnc)
% Calculates the Pareto front in the [R,m] space.
% This  algorithm calculates N architectures on the Paret, for each possible discrete value of mass the
% architecture that maximizes reliability with a mass less or equal than
% the value. 
% 
% Inputs: 
%           vec_gnc vector of architectures
% Outputs:
% front = vector with the indexes of the optimal architectures
% NS,NC = vectors containing the percentage of components of sensors and
% computers that are A, B, or C in the architectures on the Pareto front. 
% Ex : NS = [40,30,30] means that 40% of the sensors of the architectures 
% on the Pareto front are A's, 30% are B's and 30% are C's.
% CS : percentage of cross-strapped architectures on the Pareto Front

%% Initializations
% pctg = 0;
% pctg2 = 0;
% m_min = vec_gnc(1).m; % Architecture # 1 is always the lightest A-A
% m_max = vec_gnc(end).m; % Last arhitecture is always the heaviest CCC-CCC
% dm = (m_max-m_min)/(Npoints-1);
%front = zeros(Npoints,1);


NA = 0;
NB = 0;
NC = 0;
NT = 0;
NCA = 0;
NCB = 0;
NCC = 0;
NCT = 0;

%% Get vectors of masses and reliabilities
Narc = length(vec_gnc);
vec_m = zeros(Narc,1);
vec_R = zeros(Narc,1);
vec_N9 = zeros(Narc,1);

for i = 1:Narc
    vec_m(i) = vec_gnc(i).m;
    vec_R(i) = vec_gnc(i).R;
    vec_N9(i) = vec_gnc(i).N9;
end

%% Calculate the Pareto front using an existing algorithm paretofront.m
vec_1 = ones(Narc,1);
vec_U = vec_1-vec_R;
ind = paretofront([vec_U vec_m]);
j = 1;
for i = 1:length(ind)
    if ind(i) == 1
        front(j) = i;
        j = j+1;
    end
end
 %% Count component types and cross-strapped architectures on the Pareto Front   
        % Count A's B's and C's in the Pareto front 

pctg = 0;
N_homogen = 0;
indexes_CS = zeros(length(front),1);
indexes_homo = zeros(length(front),1);
indexes_SA = zeros(length(front),1);
indexes_SC = zeros(length(front),1);

nsa = 0;
nsc=0;
for j = 1:length(front)
    s1 = vec_gnc(front(j)).sensors(1);
    s2 = vec_gnc(front(j)).sensors(2);
    s3 = vec_gnc(front(j)).sensors(3);
    c1 = vec_gnc(front(j)).computers(1);
    c2 = vec_gnc(front(j)).computers(2);
    c3 = vec_gnc(front(j)).computers(3);
    
    % Count percentage of cross-strapped architectures
    ns = vec_gnc(front(j)).NS;
    nc = vec_gnc(front(j)).NC;
    if vec_gnc(front(j)).Ibin  == 49*ones(ns,nc)
        pctg = pctg + 1;
        indexes_CS(pctg) = j;
    end

    % Count percentage of homogeneous architectures
    bool_homog = 1;
    
    if ns == 1
    elseif ns == 2
        if s1 ~= s2
            bool_homog = 0;
        end
    else
        if ~(s1 == s2 && s2 == s3)
            bool_homog = 0;
        end
    end
    
    if nc == 1
    elseif nc == 2
        if c1 ~= c2
            bool_homog = 0;
        end
    else
        if ~(c1 == c2 && c2 == c3)
            bool_homog = 0;
        end
    end
    
    if bool_homog == 1
        N_homogen = N_homogen + 1;
        indexes_homo(N_homogen) = j;
    end
    % Count percentages of components
    if s1 == 49
        NA = NA + 1;
        
        NT = NT + 1;
    elseif s1 == 50
        NB = NB + 1;
        NT = NT + 1;
    elseif s1 == 51
        NC = NC + 1;
        NT = NT + 1;
    end

    if s2 == 49
        NA = NA + 1;
        NT = NT + 1;
    elseif s2 == 50
        NB = NB + 1;
        NT = NT + 1;
    elseif s2 == 51
        NC = NC + 1;
        NT = NT + 1;
    end

    if s3 == 49
        NA = NA + 1;
        NT = NT + 1;
    elseif s3 == 50
        NB = NB + 1;
        NT = NT + 1;
    elseif s3 == 51
        NC = NC + 1;
        NT = NT + 1;
    end

    if c1 == 49
        NCA = NCA + 1;
        NCT = NCT + 1;
    elseif c1 == 50
        NCB = NCB + 1;
        NCT = NCT + 1;
    elseif c1 == 51
        NCC = NCC + 1;
        NCT = NCT + 1;
    end

    if c2 == 49
        NCA = NCA + 1;
        NCT = NCT + 1;
    elseif c2 == 50
        NCB = NCB + 1;
        NCT = NCT + 1;
    elseif c2 == 51
        NCC = NCC + 1;
        NCT = NCT + 1;
    end

    if c3 == 49
        NCA = NCA + 1;
        NCT = NCT + 1;
    elseif c3 == 50
        NCB = NCB + 1;
        NCT = NCT + 1;
    elseif c3 == 51
        NCC = NCC + 1;
        NCT = NCT + 1;
    end
    
    if s1 == 49 || s2 == 49 || s3 == 49
        nsa = nsa + 1;
        indexes_SA(nsa) = j;
        
    end
    
    if s1 == 51 || s2 == 51 || s3 == 51
        nsc = nsc + 1;
        indexes_SC(nsc) = j;
        
    end
    
end
indexes_CS(pctg+1:end) = [];
indexes_SA(nsa+1:end) = [];
indexes_SC(nsa+1:end) = [];

indexes_homo(N_homogen+1:end) = [];
%% Plot paretofront

vec_N92 = vec_N9(front);
vec_m2 = vec_m(front);
% vec_R2 = vec_R(front);
txt1 = '# of 9''s in R';
txt2 = 'Mass (adimensional)';
figure;
plot(vec_N9,vec_m,'kx');
hold on;
plot(vec_N92,vec_m2,'k-','ButtonDownFcn',{@gnc_sens_plot,vec_gnc(front),vec_m2,vec_N92});
legend({'All architectures','Non-dominated architectures'});
xlabel(txt1,'Fontsize',12);
ylabel(txt2,'Fontsize',12);



% vec_R2 = vec_R(front);
txt1 = '# of 9''s in R';
txt2 = 'Mass (adimensional)';
figure;
plot(vec_N9,vec_m,'kx');
hold on;
plot(vec_N92,vec_m2,'k-');
plot(vec_N92(indexes_CS),vec_m2(indexes_CS),'ks');
legend({'All architectures','Non-dominated architectures','Fully cross-strapped architectures'});
xlabel(txt1,'Fontsize',12);
ylabel(txt2,'Fontsize',12);
% title(fig_name,'Fontsize',15);


% vec_R2 = vec_R(front);
txt1 = '# of 9''s in R';
txt2 = 'Mass (adimensional)';
figure;
plot(vec_N9,vec_m,'bx');
hold on;
plot(vec_N92(indexes_homo),vec_m2(indexes_homo),'go');
legend({'Not homogeneous','Homogeneous'});
xlabel(txt1,'Fontsize',12);
ylabel(txt2,'Fontsize',12);



% title(fig_name,'Fontsize',15);

%% Original statistics on entire tradespace
pctg2 = 0;
N_homogen2 = 0;
indexes_CS2 = zeros(length(front),1);
indexes_homo2 = zeros(length(front),1);
indexes_SA2 = zeros(length(front),1);
indexes_SC2 = zeros(length(front),1);

indexes_AAA = zeros(length(front),1);
nAAA = 0;
nsa2 = 0;
nsc2 = 0;
for j = 1:length(vec_gnc)
    s1 = vec_gnc(j).sensors(1);
    s2 = vec_gnc(j).sensors(2);
    s3 = vec_gnc(j).sensors(3);
    c1 = vec_gnc(j).computers(1);
    c2 = vec_gnc(j).computers(2);
    c3 = vec_gnc(j).computers(3);
    
    % Count percentage of cross-strapped architectures
    ns = vec_gnc(j).NS;
    nc = vec_gnc(j).NC;
    if vec_gnc(j).Ibin  == 49*ones(ns,nc) 
        pctg2 = pctg2 + 1;
        indexes_CS2(pctg2) = j;
    end

    % Count percentage of homogeneous architectures
    bool_homog = 1;
    
    if ns == 1
    elseif ns == 2
        if s1 ~= s2
            bool_homog = 0;
        end
    else
        if ~(s1 == s2 && s2 == s3)
            bool_homog = 0;
        end
    end
    
    if nc == 1
    elseif nc == 2
        if c1 ~= c2
            bool_homog = 0;
        end
    else
        if ~(c1 == c2 && c2 == c3)
            bool_homog = 0;
        end
    end
    
    if bool_homog == 1
        N_homogen2 = N_homogen2 + 1;
        indexes_homo2(N_homogen2) = j;
    end
    % Count percentages of components
    if s1 == 49
        NA = NA + 1;
        
        NT = NT + 1;
    elseif s1 == 50
        NB = NB + 1;
        NT = NT + 1;
    elseif s1 == 51
        NC = NC + 1;
        NT = NT + 1;
    end

    if s2 == 49
        NA = NA + 1;
        NT = NT + 1;
    elseif s2 == 50
        NB = NB + 1;
        NT = NT + 1;
    elseif s2 == 51
        NC = NC + 1;
        NT = NT + 1;
    end

    if s3 == 49
        NA = NA + 1;
        NT = NT + 1;
    elseif s3 == 50
        NB = NB + 1;
        NT = NT + 1;
    elseif s3 == 51
        NC = NC + 1;
        NT = NT + 1;
    end

    if c1 == 49
        NCA = NCA + 1;
        NCT = NCT + 1;
    elseif c1 == 50
        NCB = NCB + 1;
        NCT = NCT + 1;
    elseif c1 == 51
        NCC = NCC + 1;
        NCT = NCT + 1;
    end

    if c2 == 49
        NCA = NCA + 1;
        NCT = NCT + 1;
    elseif c2 == 50
        NCB = NCB + 1;
        NCT = NCT + 1;
    elseif c2 == 51
        NCC = NCC + 1;
        NCT = NCT + 1;
    end

    if c3 == 49
        NCA = NCA + 1;
        NCT = NCT + 1;
    elseif c3 == 50
        NCB = NCB + 1;
        NCT = NCT + 1;
    elseif c3 == 51
        NCC = NCC + 1;
        NCT = NCT + 1;
    end
    
    if s1 == 49 || s2 == 49 || s3 == 49
        nsa2 = nsa2 + 1;
        indexes_SA2(nsa2) = j;
        
    end
     if s1 == 51 || s2 == 51 || s3 == 51
        nsc2 = nsc2 + 1;
        indexes_SC2(nsc2) = j;
        
    end
    if s1 == 49 && s2 == 49 && s3 == 49 && c1 == 49 && c2 == 49 && c3 == 49
        nAAA = nAAA + 1;
        indexes_AAA(nAAA) = j;
        
    end
    
end
indexes_AAA(nAAA+1:end) = [];

figure;
plot(vec_N9,vec_m,'k.');
hold on;
plot(vec_N9(indexes_AAA),vec_m(indexes_AAA),'ks');
legend({'All architectures','AAA-AAA architectures'});
xlabel(txt1,'Fontsize',12);
ylabel(txt2,'Fontsize',12);
%% Results
N_homogen = N_homogen/length(front);
CS = 100*pctg/length(front);
NS = 100.*[NA NB NC]./NT;
NC = 100.*[NCA NCB NCC]./NCT;
NSA = 100*nsa/length(front);
NSC = 100*nsc/length(front);

N_homogen2 = N_homogen2/length(vec_gnc);
CS2 = 100*pctg2/length(vec_gnc);
NSA2 = 100*nsa2/length(vec_gnc);
NSC2 = 100*nsc2/length(vec_gnc);

return
    
        
    