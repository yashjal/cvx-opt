n = size(A,2);
cvx_begin
    variable x(n);
    minimize(0.5*sum_square(A*x - b)+1.0*norm(x,1))
cvx_end
