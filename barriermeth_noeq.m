function [x,gaps,start,i] = barriermeth_noeq(funs,t,mu,x,eps,maxit,alpha,beta,tol,m)
% primal barrier method, with no equality constraints    
    gaps = zeros(maxit,2);  % duality gaps
    start = 0;
    
    % primal barrier algorithm
    for i=1:2:2*maxit
        % newton method on the barrier objective
        [x,iters,flag] = newtMethBarrier(funs,t,x,alpha,beta,maxit,tol,m);
        
        % info for plots
        gap = m/t;
        gaps(i,1) = start;
        gaps(i,2) = gap;
        
        % flag is 1 when newton method does not find sufficient descent
        if flag
            fprintf('did not find newton descent!\n');
            break;
        end
        
        % stopping criterion: target duality gap achieved
        if gap < eps
            fprintf('gap<eps\n');
            break;
        end
        
        start = start+iters;
        gaps(i+1,1) = start;
        gaps(i+1,2) = gap;
        t = mu*t;   % update barrier param t
    end
    
end