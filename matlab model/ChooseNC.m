function [GNCout] = ChooseNC(GNCin)
% Choose number of sensors
global NCMAX
j = 1;
for i = 1:length(GNCin)
    for nc = 1:NCMAX
        GNCout(j)    = GNCin(i);
        GNCout(j).NC = nc;
        j = j + 1;
    end
end
return;

        
    