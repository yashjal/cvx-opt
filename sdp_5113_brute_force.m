function [xmin,p] = sdp_5113_brute_force(W)
[m,n] = size(W);
x = ones(n,1);
p = x'*W*x;
xmin = x;
perm = dec2base(0:2^n-1, 2)-'0';
perm(perm==0) = -1;
iter = size(perm,1);

for i=1:iter
    x = perm(i,:);
    tmp = x*W*x';
    if tmp < p
        p = tmp;
        xmin = x;
    end
end

end

