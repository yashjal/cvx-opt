function [x,f_new,g_new,H_new] = BTLS2(obj,ineq,x,f,g,H,d,iters,alpha,beta)
    suff_descent = 0; i = 0;
    b = 1;
    % BTLS
    while (suff_descent == 0 && i < 20)
        x = x + b*d;
        [f_new, g_new,H_new] = fun(x);
        fprintf('        Backtrack: New cost: %f, Old cost: %f\n', f_new, f);
        if (f_new < f + alpha * beta * g' * d)
            suff_descent = 1;
            fprintf('Iter %d: #backtracks: %d, f: %2.16f.\n',iters,i,f_new);
        else
            b = b*beta;
        end
        i = i+1;
    end
    if (suff_descent == 0)
        fprintf('Did not find sufficient descent!\n');
        return;
    end

end