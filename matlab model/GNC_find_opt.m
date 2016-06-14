function [ind_opt] = GNC_find_opt(vec_gnc,Rtarget)
% Calculates the optimum architecture from vec_gnc by applying the
% following criterion: 
% From all the architectures with R >= Rtarget, choose the one with minimum
% mass
% Returns the index of the optimum architecture in vec_gnc and the
% structure with the optimum architecture.

Narc = length(vec_gnc);
m_min = 1e15;
r_opt = 0;
ind_tmp = 0;
for i = 1:Narc
    R_tmp = vec_gnc(i).R; 
    if (R_tmp >= Rtarget) || ( (abs(Rtarget - R_tmp) <= (1-Rtarget)/10) ) % We let a certain tolerance
        m_tmp = vec_gnc(i).m;
        if (m_tmp < m_min) || (m_tmp == m_min && R_tmp > r_opt)
            ind_tmp = i;
            m_min = m_tmp;
            r_opt = R_tmp;
        end
    end
end

if ind_tmp > 0
    ind_opt = ind_tmp;
    gnc_opt = vec_gnc(ind_opt);
    %fprintf('Optimum architecture: gncs(%d). Mass = %f, R= %f\n',ind_opt,gnc_opt.m, gnc_opt.R);
else
    ind_opt = [];
    gnc_opt = [];
    fprintf('GNC_find_opt: No architecture satisfying the constraint was found.\n');
end


return

