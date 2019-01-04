% generate random matrix of size q and fixed rank
q = 100;
rank = 10;
X = randn(q,rank)*randn(rank,q);
[m,n] = size(X);
k = 7500;   % # entries specified

% generate random_indices,A,b (for constraints)
k_rand = zeros(k,2);
b_actual = zeros(k,1);
A = [];     % A([W1 X;X' W2])=b constraint
iter = 1;
while iter <= k
    a = ceil(m*rand);
    b = ceil(n*rand);
    inc = 0;
    for j=1:iter
        if k_rand(j,1) == a && k_rand(j,2) == b
            break;
        elseif j == iter
            inc = 1;
        end
    end
    if inc == 1
        k_rand(iter,1)=a;
        k_rand(iter,2)=b;

        % fill b with the entries specified
        b_actual(iter) = X(a,b);

        % <A_tmp,[W1 X;X' W2]> = b_ij
        A_tmp = zeros(m+n,m+n);
        A_tmp(m+b,a) = 0.5;
        A_tmp(a,m+b) = 0.5;
        A_tmp = sparse(A_tmp');

        % A=[A1;A2;...]
        A = [A ; (A_tmp(:))'];
        A = sparse(A);
        iter = iter +1;
    end
end

% generate C s.t. objective = <C,[W1 X;X' W2]>
C = [0.5*eye(m) zeros(m,n); zeros(n,m) 0.5*eye(n)];
C = C';

% solve SDP using ADMM with rho=1,maxit=1000,tol=1.e-6
X_sol = nuclear_SDP_ADMM(C,A,b_actual,1,1000,X,1.e-6);
% derive X from [W1 X;X' W2]
X_sol = X_sol(1:m,m+1:m+n);
% display norm of difference
norm(X_sol-X,'fro')
