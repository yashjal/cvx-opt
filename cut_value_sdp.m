function cv = cut_value_sdp(W,V)
    cv = 0;
    [m,n] = size(W);
    for i=1:n
        vi = V(:,i);
        for j=1:n
            w = W(i,j);
            vj = V(:,j);
            cv = cv + w*(1-vi'*vj);
        end
    end
    cv = cv/4;

end

