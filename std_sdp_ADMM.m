function [X,iter,t] = std_sdp_ADMM(C,A,b,rho,X0,Z0,U0,maxit,tol)
    % initializations
    [m,n] = size(C);
    f0 = trace(C*X0);
    iter = 1;
    Z = Z0;
    U = U0;
    
    % factorize to solve linear system later
    AA = [rho*eye(n) A'; A zeros(m)];
    L = chol(AA,'lower');
    R = L';

    % main ADMM
    while iter <= maxit
        bb = [rho*(Z-U) - C; b];
        Y = L\bb;
        X = R\Y;
        X = X(1:m,:);
        % update Z: projection of X+U onto Sn+
        [UU,SS,VV] = svd(X+U);
        SS(SS<0) = 0;
        Z = UU*SS*VV';
        U = U + X - Z;
        f = trace(C*X);
        t = abs(f-f0);
        if t < tol
            break;
        end
        f0 = f;
        iter = iter+1; 
    end

end