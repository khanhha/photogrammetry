% Direct linear transformation, solver for A*x = 0
function x = solve_dlt(A) 
[U, D, V] = svd(A); % Singular value decomposition
x = V(:, end); % Last column is singular vector to the smallest singular value
end