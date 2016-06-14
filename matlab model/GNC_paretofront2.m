function [front,CS,NS,NC,NH] = GNC_paretofront2(vec_gnc,vec_Robj)
% GNC_paretofront.m
% Calculates the Pareto front in the [R,m] space.
% Each architecture in the front minimizes mass for the reliability
% objective set in vec_Robj(i)
% Inputs:
% vec_gnc = vector of architectures
% Outputs
% front = vector with the indexes of the optimal architectures
% pctg = percentage of architectures from the pareto front that are
% cross-strapped


Nrel = length(vec_Robj);
CS = 0;
front = zeros(Nrel,1);
N_homogen = 0;
NA = 0;
NB = 0;
NC = 0;
NT = 0;
NCA = 0;
NCB = 0;
NCC = 0;
NCT = 0;
% Calculates the percentage of architectures that are cross-strapped.
for j =1:Nrel
    % Calculate Pareto front with algorithm2
    front(j) = GNC_find_opt(vec_gnc,vec_Robj(j));
    
    % Cross-strapped architectures
    ns = vec_gnc(front(j)).NS;
    nc = vec_gnc(front(j)).NC;
    if vec_gnc(front(j)).Ibin  == 49*ones(ns,nc)
        CS = CS + 1;
    end
    
    % Homogeneous architectures
    
    s1 = vec_gnc(front(j)).sensors(1);
    s2 = vec_gnc(front(j)).sensors(2);
    s3 = vec_gnc(front(j)).sensors(3);
    c1 = vec_gnc(front(j)).computers(1);
    c2 = vec_gnc(front(j)).computers(2);
    c3 = vec_gnc(front(j)).computers(3);
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
    
end


%% Results
NH = 100*N_homogen/length(front);
CS = 100*CS/length(front);
NS = 100.*[NA NB NC]./NT;
NC = 100.*[NCA NCB NCC]./NCT;
return

    
        
    