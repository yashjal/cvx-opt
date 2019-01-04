function [X,Z,y] = std_sdp_cvx(C,A,b)
    [m,n] = size(C);
    cvx_begin sdp
        variable X(n,n) symmetric
        dual variables Z y
        minimize(trace(C*X))
        Z : X >= 0
        y : trace(A*X) == b
    cvx_end
end