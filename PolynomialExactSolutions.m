function [solutions] = PolynomialExactSolutions(d)
n=linspace(0,d-1,d);
phi=(pi*2/d).*n;
solutions=exp(phi.*sqrt(-1));


end