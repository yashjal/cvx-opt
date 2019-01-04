function [x,Z] = dual_5114(W)
[m,n] = size(W);
my_ones = ones(1,n);

cvx_begin sdp
    variable x(n)
    dual variable Z
    maximize(-my_ones*x)
    Z : W + diag(x) >= 0
cvx_end

end