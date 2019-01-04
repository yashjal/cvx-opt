function out = S(a,k)
% soft thresholding operator
out = zeros(size(a,1),1);

for i=1:size(a,1)
    if a(i)>k
        out(i) = a(i)-k;
    elseif a(i)<-k
        out(i) = a(i)+k;
    else
        out(i) = 0;
    end
end

end

