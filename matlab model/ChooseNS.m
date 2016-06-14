function [GNCout] = ChooseNS(GNCin)
% Choose number of sensors
global NSMAX

for ns = 1:NSMAX
        GNCout(ns)    = GNCin;
        GNCout(ns).NS = ns;
end
return;
        
    