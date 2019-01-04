function [x_c, r] = ball_polyhedron(A, b)

l = length(b);
cvx_begin
    variable r(1)
    variable x_c(2)
    maximize ( r )
    for i=1:l
        a = A(:,i);
        a'*x_c + r*norm(a,2) <= b(i);
    end
cvx_end

% Generate the figure
x = linspace(-2,2);
theta = 0:pi/100:2*pi;
a1 = A(:,1);
plot( x, -x*a1(1)./a1(2) + b(1)./a1(2),'b-');
hold on
for j=2:l
    aj = A(:,j);
    plot( x, -x*aj(1)./aj(2) + b(j)./aj(2),'b-');
end
plot(x_c(1) + r*cos(theta), x_c(2) + r*sin(theta), 'r');
plot(x_c(1),x_c(2),'k+')
xlabel('x_1')
ylabel('x_2')
title('Largest Euclidean ball lying in a 2D polyhedron');
axis([-1 1 -1 1])
axis equal

end