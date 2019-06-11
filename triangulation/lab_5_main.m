clear all;
close all;

fh = fopen('bh.dat', 'r');
% 4 rows, 1383 columns
A = fscanf(fh, '%f%f%f%f', [4 inf]);
fclose(fh);

% Coordinates in 4 rows to columns
x1 = A(1:2, :);
x2 = A(3:4, :);
N = size(x1, 2);
x1 = [x1; ones(1,N)];
x2 = [x2; ones(1,N)];

%find projection marices
F = fundamental_matrix(x1, x2);
[Pn, P] = projection_matrices(F);

%projective reconstruction
X = linear_triangulation(Pn, P, x1, x2);

% draw result
figure; scatter3(X(1,:), X(2,:), X(3,:), 'filled');
axis square; view(32, 75);

fh = fopen('pp.dat', 'r');
% 7 rows
A1 = fscanf(fh, '%f%f%f%f%f%f', [7 inf]);
fclose(fh);
x1_ = A1(1:2, :);
x2_ = A1(3:4, :);
XE_ = A1(5:7, :);
NE  = size(XE_, 2);
XE_ = [XE_; ones(1,NE)];

%projective reconstruction for ground truth correspondences
X_  = linear_triangulation(Pn, P, x1_, x2_);

%estimate 3d homography from projective reconstruction to Euclidean reconstruction
H  = homo_3d(X_, XE_);

%transform the projective reconstruction to Euclidean reconstruction
X_ret = H * X;
X_ret = X_ret ./ X_ret(4,:);
figure; scatter3(X_ret(1,:), X_ret(2,:), X_ret(3,:), 'filled');
axis square; view(32, 75);

