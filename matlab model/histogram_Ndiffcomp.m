function vec_Ndiffcomp = histogram_Ndiffcomp(vec_gncs)
%% This function counts the number of different components on the vector of GNCs
% (usually the pareto front) that have 2,3...,6 different components.
% Usage : vec_Ndiffcomp = histogram_Ndiffcomp(gncs(front))
%% Begin
Narc = length(vec_gncs);
vec_Ndiffcomp = zeros(5,1);
for i = 1:Narc
    sen = vec_gncs(i).sensors;
    com = vec_gncs(i).computers;
    ncomps = GNC_countComp(sen) + GNC_countComp(com); % The sum can be between 2 and 6.
    vec_Ndiffcomp(ncomps-1) = vec_Ndiffcomp(ncomps-1) + 1;%vec_Ndiffcomp(1) counts the arch with only 2 diff comp.
end

return