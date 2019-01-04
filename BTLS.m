function [x,f_new,g_new] = BTLS(fun, x, f, g, d, iters)
    beta = 1; alpha = 0.25;
    suff_descent = 0; i = 0;
    % BTLS
    while (suff_descent == 0 && i < 20)
        x = x + beta*d;
        [f_new, g_new] = fun(x);
        fprintf('        Backtrack: New cost: %f, Old cost: %f\n', f_new, f);
        if (f_new < f + alpha * beta * g' * d)
            suff_descent = 1;
            fprintf('Iter %d: #backtracks: %d, f: %2.16f.\n',iters,i,f_new);
        else
            beta = beta/2;
        end
        i = i+1;
    end
    if (suff_descent == 0)
        fprintf('Did not find sufficient descent!\n');
        return;
    end

end