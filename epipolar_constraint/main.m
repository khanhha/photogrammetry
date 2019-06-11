clear;
close all;

X1_ = load('./pnts_3');
X2_ = load('./pnts_4');
X1_ = X1_.pnts';
X2_ = X2_.pnts';
X1_(3,:) = 1;
X2_(3,:) = 1;

T1 = condition2(X1_);
T2 = condition2(X2_);
X1 = T1*X1_;
X2 = T2*X2_;
 
A = design_matrix(X1, X2);

f = solve_dlt(A);

F_ = reshape(f, 3, 3)';

[U,D,V] = svd(F_);

F = U * diag([D(1,1) D(2,2) 0]) * V';

F = T2' * F * T1;

I1 = imread('./3.jpg');
I2 = imread('./4.jpg');

geo_error = geo_error(F, X1_, X2_)

disp('error is '); disp(geo_error)

figure, 
subplot(1,2,1), imshow(I1), hold on;
plot(X1_(1,:), X1_(2,:), 'r*');
for i = 1:size(X2_, 2)
  x1 = X1_(:,i);
  x2 = X2_(:,i);
  l = F'*x2;
  hline(l);
end

subplot(1,2,2), imshow(I2), hold on;
plot(X2_(1,:), X2_(2,:), 'r*');
for i = 1:size(X1_,2)
  x1 = X1_(:,i);
  x2 = X2_(:,i);
  l = F*x1;
  hline(l);
end
