function xmin,p = sdp_5113_brute_force(W)
[m,n] = size(W);
x = ones(n,1);
p = x'*W*x;
xmin = x;

for i=1:n
    for j=(i+1):n
        x(j) = -1;
        tmp = x'*W*x;
        if tmp < p
            p = tmp;
            xmin = x;
        end
        x(j) = 1;
    end
    x(i) = -1;
end

end

