Narc = length(gncs);
vec_m(1) = gncs(1).m; % vector with all the different masses
k = 1;% indicates size of vec_m
for i = 2:Narc
    m_tmp = gncs(i).m; % current mass
    found = 0;
    for j = 1:k
        if m_tmp == vec_m(j)
            found = 1;
            break;
        end
    end
    if found == 0
        vec_m(k+1) = m_tmp;
        k = k + 1;
    end
end
