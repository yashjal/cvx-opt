function [x,y,f,f1,iters,grads,grads2] = nesterovmeth(fun, x0, tol, maxit, m, M)
% code for nesterov optimal gradient method

    x = x0;
    y = x0;
    [f,g] = fun(y);
    iters = 1;
    grads = zeros(1,maxit);
    grads2 = zeros(1,maxit);
    grads(iters) = norm(g);
    grads2(iters) = norm(g);
    k = M/m;
    q = (1-(1/k)^0.5)/(1+(1/k)^0.5);
    while (iters <= maxit && grads(iters) >= tol)
        xnew = y - g./M;
        y = xnew + q*(xnew-x);
        x = xnew;
        [f,g] = fun(y);
        [f1,g1] = fun(x);
        iters = iters+1;
        grads(iters) = norm(g);
        grads2(iters) = norm(g1);
    end
end