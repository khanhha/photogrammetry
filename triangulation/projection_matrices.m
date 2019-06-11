% seciond 9.5 "Retrieving the camera matrices"
function [Pn, P] = projection_matrices (F)
[U, D, V] = svd(F);

e1 = V(:, 3);
e2 = U(:, 3);

re2 = repmat(e2, [1 3]);

skew = [0 -e2(3) e2(2) ; e2(3) 0 -e2(1) ; -e2(2) e2(1) 0 ];

P1 = (skew * F) + re2;

P  = [P1 e2];
Pn = [eye(3) zeros(3,1)];
end