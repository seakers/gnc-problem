function [GNCout] = ChooseActuators(GNCin)
% GNC = ChooseActuators(GNC)
% Generates all possible architectures with combinations of actuators of type
% A, B or C

global ACTUATORS M_ACTU

j = 1;
for i = 1:length(GNCin)
    if GNCin(i).NA == 1
        for act = 1:3
            GNCout(j)    = GNCin(i);
            GNCout(j).actuators = ACTUATORS(act,:);
            GNCout(j).m = GNCout(j).m + M_ACTU(act);
            j = j + 1;
        end
    elseif GNCin(i).NA == 2
        for act = 4:9
            GNCout(j)    = GNCin(i);
            GNCout(j).actuators = ACTUATORS(act,:);
            GNCout(j).m = GNCout(j).m + M_ACTU(act);
            j = j + 1;
        end
    elseif GNCin(i).NA == 3
        for act = 10:19
            GNCout(j)    = GNCin(i);
            GNCout(j).actuators = ACTUATORS(act,:);
            GNCout(j).m = GNCout(j).m + M_ACTU(act);
            j = j + 1;
        end
    else %error
    end
 
end
return;