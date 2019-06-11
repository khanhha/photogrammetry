function T = condition2(x)
 tx = mean(x(1,:));
 ty = mean(x(2,:));
 sx = mean(abs(x(1,:)-tx));
 sy = mean(abs(x(2,:)-ty));
 T = [1/sx 0     -tx/sx;
      0    1/sy  -ty/sy
      0    0      1]; 
 end