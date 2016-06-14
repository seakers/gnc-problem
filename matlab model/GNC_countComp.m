function ncomps = GNC_countComp(vec_comp)
%% GNC_countComp.m
% ncomps = GNC_countComp(gncs(i).sensors) + GNC_countComp(gncs(i).computers)
% This function calculates the number of different types of components
% used in an architecture for either sensors or computers. It can be 1, 2
% or 3. 

if strcmp(vec_comp,'100') || strcmp(vec_comp,'200') || strcmp(vec_comp,'300') ||  strcmp(vec_comp,'110') || strcmp(vec_comp,'220') || strcmp(vec_comp,'330') ||  strcmp(vec_comp,'111') || strcmp(vec_comp,'222') || strcmp(vec_comp,'333')
    ncomps = 1;
elseif strcmp(vec_comp,'120') || strcmp(vec_comp,'130') || strcmp(vec_comp,'230') || strcmp(vec_comp,'112') || strcmp(vec_comp,'113') || strcmp(vec_comp,'122') || strcmp(vec_comp,'223') || strcmp(vec_comp,'133') || strcmp(vec_comp,'233')
    ncomps = 2;
elseif strcmp(vec_comp,'123')
    ncomps = 3;
else
    ncomps = -1;
    fprintf('[GNC_countComp]: Error ncomps = -1\n');
end
return