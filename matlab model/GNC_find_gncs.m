function gncs_out = GNC_find_gncs(gncs_in,Rlim)
%% GNC_find_gncs.m
% This function searches the vector gncs_in for elements that have
% R>=Rlim. gncs_out is another vector of gnc structures containing only
% the elements of gncs_in that have R>=Rlim

len = length(gncs_in);
j = 1;
for i =1:len
    if gncs_in(i).R >=Rlim
        gncs_out(j) = gncs_in(i);
        j = j + 1;
    end
end
