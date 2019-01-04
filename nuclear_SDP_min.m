function [X] = nuclear_SDP_min(Xa,k)
    [m,n] = size(Xa);
    
    % generate random indices
    k_rand = zeros(k,2);
    iter = 1;
    while iter <= k
        a = ceil(m*rand);
        b = ceil(n*rand);
        inc = 0;
        for j=1:iter
            if k_rand(j,1) == a && k_rand(j,2) == b
                break;
            elseif j == iter
                inc = 1;
            end
        end
        if inc == 1
            k_rand(iter,1)=a;
            k_rand(iter,2)=b;
            iter = iter +1;
        end
    end
    
    % sdp matrix completion
    cvx_begin sdp
        variable W1(m,m) symmetric
        variable W2(n,n) symmetric
        variable X(m,n)
        minimize(0.5*(trace(W1)+trace(W2)))
        [W1 X; X' W2] >= 0
        for i=1:k
           X(k_rand(i,1),k_rand(i,2)) == Xa(k_rand(i,1),k_rand(i,2))
        end
    cvx_end
    
    % display the difference between soln and actual
    %abs(Xa-X)
    norm(Xa-X,'fro')
end