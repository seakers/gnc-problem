function [GNCout] = ChooseComputers(GNCin)
% GNC = ChooseComputers(GNC)
% Generates all possible architectures with combinations of computers of type
% A, B or C

global COMPUTERS M_COMP

j = 1;
for i = 1:length(GNCin)
    if GNCin(i).NC == 1
        for com = 1:3
            GNCout(j)    = GNCin(i);
            GNCout(j).computers = COMPUTERS(com,:);
            GNCout(j).m = GNCout(j).m + M_COMP(com);
            j = j + 1;
        end
    elseif GNCin(i).NC == 2
        for com = 4:9
            GNCout(j)    = GNCin(i);
            GNCout(j).computers = COMPUTERS(com,:);
            GNCout(j).m = GNCout(j).m + M_COMP(com);
            j = j + 1;
        end
    elseif GNCin(i).NC == 3
        for com = 10:19
            GNCout(j)    = GNCin(i);
            GNCout(j).computers = COMPUTERS(com,:);
            GNCout(j).m = GNCout(j).m + M_COMP(com);
            j = j + 1;
        end
    else %error
    end
 
end
return;