function [m,N9,indexes] = GNC_archs_with_minNSNC(gncs,n)
    N = length(gncs);
    m = zeros(N,1);
    N9 = zeros(N,1);
    indexes = zeros(N,1);
    i = 1;
    for j = 1:N
        if gncs(j).minNSNC == n
            m(i) = gncs(j).m;
            N9(i) = gncs(j).N9;
            indexes(i) = j;
            i = i + 1;
        end
    end
    m(i:end) = [];
    N9(i:end) = [];
    indexes(i:end) = [];
end