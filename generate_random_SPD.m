function X = generate_random_SPD(n)

    X = rand(n);
    X = X*X';
    X = X + n*eye(n);

end

