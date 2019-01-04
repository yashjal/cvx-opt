function [x,f,iters,grads] = gradmeth(fun, x0, tol, maxit)
% code for gradient method, including backtracking line search

    x = x0;
    [f,g] = fun(x);
    iters = 1;
    grads = zeros(1,maxit);
    grads(iters) = norm(g);
    while (iters <= maxit && grads(iters) >= tol)
        d = -g;
        [x,f,g] = BTLS(fun,x,f,g,d,iters);
        iters = iters+1;
        grads(iters) = norm(g);
    end
end