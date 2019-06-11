% Conditioning for object points
function T = condition3(X) 
% =============
tx = mean(X(1,:)); 
ty = mean(X(2,:)); 
tz = mean(X(3,:));

sx = mean(abs(X(1,:) - tx)); 
sy = mean(abs(X(2,:) - ty)); 
sz = mean(abs(X(3,:) - tz));

T = [ 1/sx, 0,    0,     -tx/sx;
      0,    1/sy, 0,     -ty/sy;
      0,    0,    1/sz,  -tz/sz;
      0,    0,    0,      1 ];
end