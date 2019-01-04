X = randn(3,2);
tmp = zeros(5);
tmp(4:5,1:3) = X';
tmp(1:3,4:5) = X;

cvx_begin sdp
    variable W1(3,3) symmetric
    variable W2(2,2) symmetric
    dual variables Y
    minimize(0.5*(trace(W1)+trace(W2)))
    Y : blkdiag(W1,W2)+tmp >= 0
cvx_end