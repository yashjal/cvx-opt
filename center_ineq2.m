function [f1,g1] = center_ineq2(x,A,m,n)
for i=1:m
    tmp = A(:,i)'*x;
    if tmp >= 1
        f1 = Inf;
        g1 = NaN*ones(n,1);
        return
    end
end
for i=1:n
    if abs(x(i)) >= 1
        f1 = Inf;
        g1 = NaN*ones(n,1);
        return
    end
end
f1 = -sum(log(1-A'*x)) - sum(log(1+x)) - sum(log(1-x));
d = 1./(1-A'*x);
g1 = A*d - 1./(1+x) + 1./(1-x);