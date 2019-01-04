function [x,f,iter] = ADMM_Lasso_big(x0,z0,u0,tol,maxit,rho,A,b,lam)
% ADMM for Lasso big sparse problem
    fun = @(x,lam)0.5*sum_square(A*x-b)+lam*norm(x,1);
    f0 = fun(x0,lam);
    iter = 1;
    AA = A'*A + rho*speye(size(A,2));
    L = chol(AA,'lower');
    nnz(L)
    Ab = A'*b;
    z = z0;
    u = u0;

    function out = S(a,k)
    % soft thresholding operator
        out = zeros(size(a,1),1);
        for i=1:size(a,1)
            if a(i)>k
                out(i) = a(i)-k;
            elseif a(i)<-k
                out(i) = a(i)+k;
            else
                out(i) = 0;
            end
        end
    end

    while iter <= maxit
        y = L\(Ab+rho.*(z-u));
        x = L'\y;
        z = S(x+u,lam/rho);
        u = u + x - z;
        f = fun(x,lam);
        if abs(f-f0) < tol
            break;
        end
        f0 = f;
        iter = iter+1; 
    end
end