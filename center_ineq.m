function [f1,g1,H] = center_ineq(x,A,m,n)
f = 0;
g = zeros(n,1);
for i=1:m
    tmp = A(:,i)'*x;
    if tmp >= 1
        f1 = Inf;
        g1 = NaN*ones(n,1);
        H = NaN*ones(n,n);
        return
    end
    f = f - log(1-tmp);
    g = g + A(:,i)./(1-tmp);
end
for i=1:n
    if abs(x(i)) >= 1
        f1 = Inf;
        g1 = NaN*ones(n,1);
        H = NaN*ones(n,n);
        return
    end
    f = f - log(1-x(i)^2);
    g(i) = g(i) + 2*x(i)/(1-x(i)^2);
end
f1 = -sum(log(1-A'*x)) - sum(log(1+x)) - sum(log(1-x));
d = 1./(1-A'*x);
g1 = A*d - 1./(1+x) + 1./(1-x);
H = A*diag(d.^2)*A' + diag(1./(1+x).^2 + 1./(1-x).^2);
