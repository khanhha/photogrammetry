function F = fundamental_matrix (x1, x2)
T1 = condition2(x1);
x1 = T1*x1;
T2 = condition2(x2);
x2 = T2*x2;

% Design matrix A
% A = ones(n, 9);
A = [];
for i = 1:size(x1,2)
  A = [ A; x2(1, i)*x1(:, i)' x2(2, i)*x1(:, i)' x2(3, i)*x1(:, i)' ];
end

% Solve A*f = 0
[U, D, V] = svd(A);
fv = V(:, end);

% Reshape solution
Fr = reshape(fv, 3, 3);
Fs = T2' * Fr' * T1;

% Singularity Constraint
[Uf, Df, Vf] = svd(Fs);

% Delete the smallest singular value
[_, smallest_idx] = min(diag(Df));
Df(smallest_idx, smallest_idx) = 0.0;

F = Uf * Df * Vf';
end