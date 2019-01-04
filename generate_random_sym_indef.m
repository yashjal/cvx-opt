function X = generate_random_sym_indef(n)

    X = randn(n);
    X = 0.5*(X+X');
    
end

