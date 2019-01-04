function t = maxt_SDP(X,B)
% returns largest scalar t such that
% X+tB >= 0 given X > 0, B = B'
    
    R = chol(X);
    L = R';
    
    % 1/t is the max eig of -L^(-1) B R^(-1)
    eigs_rec_mtr = -inv(L)*B*inv(R);
    eigs_rec = eig(eigs_rec_mtr);
    t_rec = max(eigs_rec);
    
    % t is inf if the eig comp above is <= 0
    if t_rec > 0
        t = 1/t_rec;
    else
        t = inf;
    end

end