function res = Poisson(k,lambda,t)
res = (exp(-lambda*t))*((lambda*t)^k)/factorial(k);