function x=simpleLP(c)
% solve the LP max c'*x subject to x>=0, sum(x)=1
n = length(c);
cvx_begin
    variable x(n)
    maximize(c'*x)
    x >= 0
    sum(x) == 1
cvx_end