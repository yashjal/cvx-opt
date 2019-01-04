% example for using CVX
function [unc_lsqsol, con_lsqsol] = lsqsol(A,b)
% unconstrained least squares: minimize ||A*x - b|| via QR factorization
% mathematically same as solving the normal equations by (A'*A)\A'*b or inv(A'*A)*(A'*b)
unc_lsqsol = A\b;  % uses QR factorization
% to solve constrained least squares, use CVX
[m,n] = size(A);
cvx_begin
    variable x(n);
    minimize(norm(A*x - b))
    x >= 0  % constraint
cvx_end
con_lsqsol = x;
    
