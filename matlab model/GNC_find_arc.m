function [ind, arc] = GNC_find_arc(gncs,ns,nc,sen,com,inat)
ind = 0;
Narc = length(gncs);
found = 0;
for i = 1:Narc
    if (gncs(i).NS == ns) && (gncs(i).NC == nc) && (strcmp(gncs(i).sensors,sen)) && (strcmp(gncs(i).computers,com)) && (isequal(gncs(i).Inat,inat))
        ind = i;
        arc = gncs(i);
        found = found + 1;
    end
end
if found == 0
    arc = [];
    fprintf('[GNC_find_arc] : Architecture not found\n');
end

return