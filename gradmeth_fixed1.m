function [x,f,iters,grads] = gradmeth_fixed1(fun, x0, tol, maxit, M)
% code for gradient method, with fixed step size 1/M

    x = x0;
    [f,g] = fun(x);
    iters = 1;
    grads = zeros(1,maxit);
    grads(iters) = norm(g);
    while (iters <= maxit && grads(iters) >= tol)
        d = -g;
        x = x + d./M;
        [f,g] = fun(x);
        iters = iters+1;
        grads(iters) = norm(g);
    end
end