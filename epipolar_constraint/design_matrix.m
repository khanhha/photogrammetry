function A = design_matrix(X1, X2)
  A = [];
  for i = 1:size(X1,2)
    t = [X1(1,i)  X1(2,i)  1.0];
    A = [A; X2(1,i)*t  X2(2,i)*t t];
  end
end
