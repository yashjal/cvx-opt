function S = partition_sdp(V,r)
[m,n] = size(V);
S = zeros(n,1);

for i=1:n
    v = V(:,i);
    if v'*r >= 0
        S(i,1) = 1;
        i
    end
end

end

