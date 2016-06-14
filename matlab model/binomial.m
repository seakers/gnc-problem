function res = binomial(k,N,p)
res = nchoosek(N,k)*p^k*(1-p)^(N-k);
return