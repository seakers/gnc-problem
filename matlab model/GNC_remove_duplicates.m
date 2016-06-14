function [gnc_out,Nduplicates] = GNC_remove_duplicates(gncs)
% GNC_remove_duplicates.m
% Usage: [gncs,Nduplicates] = GNC_remove_duplicates(gncs);
% Description : Removes all the duplicates architectures from the design
% vector
% Duplicate architectures are found because they have identical
% reliabilities, sensors, computers and links.

Narc = length(gncs);
Nduplicates = 0;
gnc_out(1) = gncs(1);
gnc_out(2) = gncs(2);
k =  3;
for i = 3:Narc
    tmp = gncs(i);
    duplicate = 0;
    for j = 1:i-1
        if tmp.R == gncs(j).R
            if tmp.sensors == gncs(j).sensors
                if tmp.computers == gncs(j).computers
                    if tmp.Nlinks == gncs(j).Nlinks
                        %fprintf('Arch %d : Found duplicate, arch %d\n',i,j);
                        duplicate = 1;
                        Nduplicates = Nduplicates + 1;
                        break;
                    end
                end
            end
        end
    end
    if duplicate == 0
        gnc_out(k) = tmp;
        k = k + 1;
    end
end

return
                        