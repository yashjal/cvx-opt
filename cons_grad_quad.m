function [Ax] = cons_grad_quad(A,x)
    Ax = cell(1,size(A,2));
    for i=1:size(A,2)
        Ax{i} = 2*A{i}*x;
    end
end

