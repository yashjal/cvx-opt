function [f,g] = quad(x,A,b)
% quadratic function f(x) = 1/2 x'Ax + b'x
f = 0.5*x'*A*x + b'*x;
g = A*x + b;
