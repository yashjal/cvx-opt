function [X] = nuclear_SDP_ADMM(C,A,b,rho,maxit,tol,Xa)
% low rank matrix completion SDP using ADMM
    n = size(C,1);
    
    % generate random symmetric psd X0,S0
    tmp0 = randn(n);
    tmp1 = randn(n);
    X = tmp0'*tmp0;
    S = tmp1'*tmp1;
    
    AA_st = A*A'; % sparse
    % precompute cholesky factors
    L_st = chol(AA_st,'lower');
    
    % main ADMM algorithm
    for k=1:maxit
        SC = S-C;
        y_tmp = full(L_st\(full(rho*(A*(X(:))-b)+A*(SC(:)))));
        y = full(L_st'\y_tmp);
        y = -y;
        
        V = C-matr(full(A'*y),n)-rho*X;
        % eigen decomposition of V
        [Q,Sig] = eig(V);
        Sig(Sig<0) = 0; % change -ve eigenvalues to 0
        
        % projection onto Sn+
        S = Q*Sig*Q';
        X = (1/rho)*(S-V);
        
        % stopping condition
        if norm(Xa-X,'fro') < tol
            break;
        end
    end
    
    % matr(x) is a matrix X s.t. x=vec(X)=X(:)
    function O = matr(v,n)
        O = zeros(n,n);
        for i=1:n
            O(:,i) = v(1+(i-1)*n:i*n);
        end
    end

end