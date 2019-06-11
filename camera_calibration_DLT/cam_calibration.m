load('pnts_2d.mat');
load('pnts_3d.mat');
N = size(pnts_2d, 1);
pnts_3d = [pnts_3d'; ones(1, N)];
pnts_2d = [pnts_2d'; ones(1, N)];
P = homo_3d_2d(pnts_3d, pnts_2d)
P = P * sign(det(P(1:3, 1:3)));

[K, R] = rq(P(1:3, 1:3))

function [R,Q] = rq(M)
    [Q,R] = qr(rot90(M,3));
    R = rot90(R,2)';
    Q = rot90(Q);
end