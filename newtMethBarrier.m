function [x,iters,flag] = newtMethBarrier(funs,t,x,alpha,beta,maxit,tol,m)
% newton method for barrier
    flag = 0;   % default value
    
    % call anonymous funs to evaluate f0, f (std. convex notation)
    obj = funs{1}; ineq = funs{2};
    % call to f0 returns f0, df0, d2f0
    eval = obj(x);
    f0 = eval{1}; g0 = eval{2}; H0 = eval{3};
    % call to f returns f, df, d2f
    eval2 = ineq(x);
    fk = eval2{1}; gk = eval2{2}; Hk = eval2{3};
    
    % compute new barrier objective using f,f0
    % also its derivative, hessian
    [f,g,H] = barrier_obj(f0,g0,H0,fk,gk,Hk,m,t);
    
    % main Newton's algorithm
    iters = 1;
    while (iters <= maxit && norm(g) >= tol)
        % if H spd, find cholesky to solve Newton eq
        [L,p] = chol(H,'lower');
        
        % H spd
        if p==0
            d_tmp = -L\g;
            d = L'\d_tmp;
        else
            fprintf('Error: hessian not pd\n');
            d = -H\g;
        end
        
        % BTLS
        suff_descent = 0; i = 0;
        b = 1; % sub for t
        while (suff_descent == 0 && i < maxit)
            % take step direction
            x_new = x + b*d;
            
            % evaluate barrier objective at new point
            eval = obj(x_new);
            f0 = eval{1}; g0 = eval{2}; H0 = eval{3};
            eval2 = ineq(x_new);
            fk = eval2{1}; gk = eval2{2}; Hk = eval2{3};
            [f_new,g_new,H_new] = barrier_obj(f0,g0,H0,fk,gk,Hk,m,t);

            fprintf('        Backtrack: New cost: %f, Old cost: %f\n', f_new, f);
            
            % Armijo condition
            if (f_new <= f + alpha * b * g' * d)
                suff_descent = 1;
                fprintf('Iter %d: #backtracks: %d, f: %2.16f.\n',iters,i,f_new);
            else
                b = b*beta;
            end
            
            i = i+1;
        end
        
        % make sure Armijo condition was met
        if (suff_descent == 0)
            fprintf('Did not find sufficient descent!\n');
            flag=1;
            break;
        end
        
        % sufficient descent was found, so update values
        f=f_new; g=g_new; H=H_new; x=x_new;
        iters = iters+1;
    end
    
end