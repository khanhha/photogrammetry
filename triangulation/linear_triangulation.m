function X = linear_triangulation(P1, P2, X1, X2)
N = size(X1, 2);
X = [];
for i = 1:N
  x1 = X1(:, i);
  x2 = X2(:, i);
  A = [x1(1)*P1(3,:) - P1(1,:); 
       x1(2)*P1(3,:) - P1(2,:); 
       x2(1)*P2(3,:) - P2(1,:); 
       x2(2)*P2(3,:) - P2(2,:)];
  %x = solve_dlt(A);
  [U D V]=svd(A);   
  x = V(:,size(V,2))./V(4,size(V,2));
  X = [X x];
end
end
