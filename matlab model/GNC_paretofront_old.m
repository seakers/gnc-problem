function [front,pctg] = GNC_paretofront(vec_gnc,vec_Robj)
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
pctg = 0;
front = zeros(Nrel,1);

% Calculates the percentage of architectures that are cross-strapped.
for i =1:Nrel
    front(i) = GNC_find_opt(vec_gnc,vec_Robj(i));
    ns = vec_gnc(front(i)).NS;
    nc = vec_gnc(front(i)).NC;
    if vec_gnc(front(i)).Ibin  == 49*ones(ns,nc)
        pctg = pctg + 1;
    end    
end

% Calculates the number of architectures that have B elements.
% for i =1:Nrel
%     front(i) = GNC_find_opt(vec_gnc,vec_Robj(i));
%     if vec_gnc(front(i)).sensors(1)  == 50 || vec_gnc(front(i)).sensors(2)  == 50 || vec_gnc(front(i)).sensors(3)  == 50
%         pctg = pctg + 1;
%     end    
% end

pctg = 100*pctg/Nrel;

return
    
        
    