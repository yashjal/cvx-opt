% generate random matrix of size q and fixed rank
q = 50;
rank = 10;
A = randn(q,rank)*randn(rank,q);

% specify number of entries 
start=500;
endi=2000;
gap=50;
norm_sol = zeros(1,(endi-start)/gap);

% solve for each size of entry
iters=1;
for i=start:gap:endi
    A_sol = nuclear_SDP_min(A,i);
    norm_sol(iters) = norm(A-A_sol,'fro');
    iters = iters+1;
end

semilogy(start:gap:endi,norm_sol,'-o','LineWidth',2)
xlabel('# entries specified')
ylabel('frobenius norm of X-X^*')
title('Rank 10 matrix completion with q=50')