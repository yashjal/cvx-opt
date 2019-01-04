% using primal barrier method with objective = -e'*x
% inequality cons = x'*Ak*x - 1 , no equality constraints

n=10; % size(A{k},2), x in Rn
m=size(A,2); % # ineq. constraints

% f0 objective, df0, d2f0
f0 = @(x){-sum(x),-ones(n,1),zeros(n,n)};

% f inequalities, df, d2f
cons_f = @(x)cellfun(@(y)x'*y*x-1,A);
cons_g = @(x)cellfun(@(y)2*y*x,A,'un',0);
cons_h = @(x)cellfun(@(y)2*y,A,'un',0);
f = @(x){cons_f(x),cons_g(x),cons_h(x)};

% anonymous func with both f0,f
funs = {f0,f};

% parameters
t = 1; alpha = 0.25; beta = 0.5; eps = 1e-6; % target duality gap
tol = 1e-6; maxit=100; x = zeros(n,1); % feasible starting pt

% PART 1
% call barrier method and plot duality gap vs Newton iter
% for different mu
mu = 5;
[x,gaps,total,i] = barriermeth_noeq(funs,t,mu,x,eps,maxit,alpha,beta,tol,m);
semilogy(gaps(1:i+1,1),gaps(1:i+1,2),'LineWidth',2)
hold on

mu = 50;
[x,gaps,total,i] = barriermeth_noeq(funs,t,mu,x,eps,maxit,alpha,beta,tol,m);
semilogy(gaps(1:i+1,1),gaps(1:i+1,2),'--','LineWidth',2)

mu = 150;
[x,gaps,total,i] = barriermeth_noeq(funs,t,mu,x,eps,maxit,alpha,beta,tol,m);
semilogy(gaps(1:i+1,1),gaps(1:i+1,2),':','LineWidth',2)

title('Duality gap versus cumulative # Newton steps for different values of \mu')
xlabel('Newton iterations')
ylabel('duality gap')
legend('\mu = 5','\mu = 50','\mu = 150')

% PART 2
% plot different values of mu vs
% total # Newton iters required by barrier method to 
% converge to desired duality gap
mu = [5,10,20,50,75,100,150,200,250];
newts = zeros(1,9);

for k=1:9
    [x,gaps,total,i] = barriermeth_noeq(funs,t,mu(k),x,eps,maxit,alpha,beta,tol,m);
    newts(k) = total;
end

plot(mu,newts,'o-','LineWidth',2)
title('Total # Newton iterations required to reduce the duality gap from 20 to 10^{-6} versus \mu ')
xlabel('\mu')
ylabel('Newton iterations')
