function [sen,com,m,R,I] = gnc_getvectors(gncs,inds)
lon = length(inds);
m = zeros(lon,1);
R = zeros(lon,1);
I = zeros(lon,3);
sen = '';
com = '';
for i = 1:lon
    m(i) = gncs(inds(i)).m;
    R(i) = gncs(inds(i)).R;
    I(i,:) = gncs(inds(i)).Inat';
    sen{i} = gncs(inds(i)).sensors;
    com{i} = gncs(inds(i)).computers;
end
sen = sen';
com = com';
return