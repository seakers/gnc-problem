function [GNCout] = ChooseNA(GNCin)
% Choose number of sensors
global NAMAX
j = 1;
for i = 1:length(GNCin)
    for na = 1:NAMAX
        GNCout(j)    = GNCin(i);
        GNCout(j).NA = na;
        j = j + 1;
    end
end
return;

        
    