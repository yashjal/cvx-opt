function [x,f,iters,grads] = newtmeth(fun, x0, tol, maxit)
% code for newton method, including backtracking line search

    x = x0;
    [f,g,H] = fun(x);
    iters = 1;
    grads = zeros(1,maxit);
    grads(iters) = norm(g);
    while (iters <= maxit && grads(iters) >= tol)
        d = -H\g;
        [x,f,g,H] = BTLS(fun,x,f,g,d,iters);
        iters = iters+1;
        grads(iters) = norm(g);
    end
end