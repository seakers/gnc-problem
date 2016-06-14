function [GNCout] = ChooseSensors(GNCin)
% GNC = ChooseSensors(GNC)
% Generates all possible architectures with combinations of sensors of type
% A, B or C

global SENSORS M_SENS

j = 1;
for i = 1:length(GNCin)
    if GNCin(i).NS == 1
        for sen = 1:3
            GNCout(j)    = GNCin(i);
            GNCout(j).sensors = SENSORS(sen,:);
            GNCout(j).m = GNCout(j).m + M_SENS(sen);
            j = j + 1;
        end
    elseif GNCin(i).NS == 2
        for sen = 4:9
            GNCout(j)    = GNCin(i);
            GNCout(j).sensors = SENSORS(sen,:);
            GNCout(j).m = GNCout(j).m + M_SENS(sen);
            j = j + 1;
        end
    elseif GNCin(i).NS == 3
        for sen = 10:19
            GNCout(j)    = GNCin(i);
            GNCout(j).sensors = SENSORS(sen,:);
            GNCout(j).m = GNCout(j).m + M_SENS(sen);
            j = j + 1;
        end
    else %error
    end
 
end
return;

