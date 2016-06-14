function vec_interconnect = interconn(com,nc)
% vec_interconnect    = interconn(GNCout(j).computers,nc)
vec_interconnect = 0;
if nc ==1
    vec_interconnect = [1];
elseif nc == 2
    if com(1) == com(2)
        vec_interconnect = [1 3];
    else
        vec_interconnect = [1 2 3];
    end
elseif nc == 3
    if com(1) == com(2) && com(3) ~= com(1)
        vec_interconnect = [1 3 4 5 7];
    elseif com(2) == com(3)&& com(3) ~= com(1)
        vec_interconnect = [1 2 3 6 7];
    elseif com(1) == com(2) && com(2) == com(3)
        vec_interconnect = [1 3 7];
    else
        vec_interconnect = [1 2 3 4 5 6 7];
    end
        
 
else
    %error
end
return

