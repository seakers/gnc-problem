function vec_Nlinks = histogram_Nlinks(vec_gncs)
%% This function counts the number of architectures on the vector of GNCs
% (usually the pareto front) that have 1,2,3...,9 links.
% Usage : vec_Nlinks = histogram_Nlinks(gncs(front))
%% Begin
Narc = length(vec_gncs);
vec_Nlinks = zeros(9,1);
for i = 1:Narc
    nlinks = vec_gncs(i).Nlinks;
    vec_Nlinks(nlinks) = vec_Nlinks(nlinks) + 1;
end

return