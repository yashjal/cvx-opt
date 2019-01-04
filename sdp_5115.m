function [X,Z,y] = sdp_5115(W)
[m,n] = size(W);

cvx_begin sdp
    variable X(n,n) symmetric
    dual variables Z y
    minimize(trace(W*X))
    Z : X >= 0
    y : diag(X) == 1
cvx_end

end