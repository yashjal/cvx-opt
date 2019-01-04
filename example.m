% this is a script showing an example of how to call quad.m via gradmeth.m
% first we need to define A and b which will be used in quad.m
n = 5;
A = hilb(n); % the Hilbert matrix, which is a very ill conditioned matrix
b = ones(n,1);
% now we define the anonymous function.  Note that the first x indicates
% that we are going to be calling the function repeatedly with different x
% but with A and b fixed
fun = @(x)quad(x, A, b)
% now we call the gradient method, which will just take one gradient step 
x0 = ones(n,1);
tol = 1e-6;
maxit = 1000;
[x,f,iters] = gradmeth(fun, x0, tol, maxit)
