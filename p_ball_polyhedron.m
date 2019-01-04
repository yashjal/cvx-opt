function [x_c, r] = p_ball_polyhedron(A, b, p)

l = length(b);
if p ~= inf
    q = p/(p-1);
else
    q = 1;
end
cvx_begin
    variable r(1)
    variable x_c(2)
    maximize ( r )
    for i=1:l
        a = A(:,i);
        %if p <= 2
        a'*x_c + r*norm(a,q) <= b(i);
        %else
        %    a'*x_c + 2^(0.5-(1/p))*r*norm(a,2) <= b(i);
        %end
    end
cvx_end

% Generate the figure
x = linspace(-2,2);
a1 = A(:,1);
plot( x, -x*a1(1)./a1(2) + b(1)./a1(2),'b-');
hold on
for j=2:l
    aj = A(:,j);
    plot( x, -x*aj(1)./aj(2) + b(j)./aj(2),'b-');
end
%y = sdpvar(2,1);
%F = norm(y-x_c,p) <= r;
%plot(F);
plot(x_c(1),x_c(2),'r+')
xlabel('x_1')
ylabel('x_2')
title('Largest p-norm ball lying in a 2D polyhedron');
axis([-1 1 -1 1])
axis equal

end