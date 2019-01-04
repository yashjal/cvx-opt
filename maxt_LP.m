function t = maxt_LP(x,b)
% returns largest scalar t such that
% x+tb >= 0 given x > 0

    n = size(x,1);
    t = inf;
    
    for i=1:n
        % t is minimum of -x(i)/b(i)
        % provided b(i) < 0
        if (b(i) < 0 && -x(i)/b(i) < t)
            t = -x(i)/b(i);
        end
    end
    % t is inf if b >= 0
    
end

