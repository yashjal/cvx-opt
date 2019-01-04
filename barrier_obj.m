function [f,g,H] = barrier_obj(f0,g0,H0,fk,gk,Hk,m,t)
% compute new barrier objective, along with derivative, hessian
% using  f0,f (std. convex notation)
    
    % old objective f0 times t
    f = t*f0;
    g = t*g0;
    H = t*H0;
    
    % barrier terms from constraints f
    for i=1:m
        % check feasibility
        if fk(i)<= 0
            f = f - log(-fk(i));
            g = g - (gk{i}/fk(i));
            H = H - (Hk{i}/fk(i)) + (gk{i}*gk{i}'/(fk(i)^2));
        else
            fprintf('infeasible');
            f = inf;
            g = zeros(size(g0,1),1);
            H = zeros(size(H0,1),size(H0,2));
            break;
        end
    end
    
end