function [f,g] = worstcase_ex(x,m,M)
    
    f = x(1)^2 - 2*x(1);
    n = size(x,1);
    for i=1:n-1
        f = f + (x(i)-x(i+1))^2;
    end
    f = f*(M-m)/8;
    f = f + 0.5*m*norm(x)^2;
    
    D = sparse(1:n,1:n,2*ones(1,n),n,n);
    E = sparse(2:n,1:n-1,-1*ones(1,n-1),n,n);
    T = E+D+E';
    id = speye(n);
    e1 = id(:,1);
    g = (((M-m)/4).*T + m.*id)*x - ((M-m)/4).*full(e1);
end