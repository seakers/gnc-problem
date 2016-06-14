function [ind_opt,U] = GNC_find_maxA(vec_gnc)
% Calculates the optimum architecture from vec_gnc by applying the
% following criterion: 
% From all the architectures with R >= Rtarget, choose the one with minimum
% mass
% Returns the index of the optimum architecture in vec_gnc and the
% structure with the optimum architecture.

Narc = length(vec_gnc);
%m_min = 1e15;
r_opt = 0;
ind_tmp = 0;
for i = 1:Narc
    if (strcmp(vec_gnc(i).sensors,'1') || strcmp(vec_gnc(i).sensors,'11') || strcmp(vec_gnc(i).sensors,'111')) && (strcmp(vec_gnc(i).computers,'1') || strcmp(vec_gnc(i).computers,'11') || strcmp(vec_gnc(i).computers,'111'))
        R_tmp = vec_gnc(i).R; 
        if (R_tmp > r_opt)
                ind_tmp = i;
                r_opt = R_tmp;
        end
    end   
end

if ind_tmp > 0
    ind_opt = ind_tmp;
    gnc_opt = vec_gnc(ind_opt);
    fprintf('[GNC_find_maxA]: Architecture giving max R with only A elements: gncs(%d). Mass = %f, R= %f\n',ind_opt,gnc_opt.m, gnc_opt.R);
    R = gnc_opt.R
    U = -log10(1-R);
else
    ind_opt = [];
    gnc_opt = [];
    fprintf('GNC_find_maxA: No architecture satisfying the constraint was found.\n');
end


return

