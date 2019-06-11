function e = geo_error(F, X1, X2)
  
  geo_error = 0.0
  
  for i = 1:size(X2, 2)
    x1 = X1(:,i);
    x2 = X2(:,i);
    x1_ =  F'*x2;
    x2_ =  F *x1;
    d = (x2_'*x1_)^2
    geo_error = geo_error + d/(sum(x1_.^2)+sum(x2_.^2));
  end
  
  e = geo_error
end
