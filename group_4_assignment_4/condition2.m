function T = condition2(x)
  tx = mean(x(1,:)); ty = mean(x(2,:)); % Translation tx, ty
  sx = mean(abs(x(1,:) - tx)); sy = mean(abs(x(2,:) - ty)); % Scaling sx, sy
  T = [ 1/sx 0 -tx/sx;
        0 1/sy -ty/sy;
        0 0 1];
end

##function T = condition2(x) % Conditioning matrix for image points
##% =============
##tx = mean(x(1,:)); 
##ty = mean(x(2,:)); % Translation tx, ty
##
##dx = x(1,:) - tx; 
##dy = x(2,:) - ty; % Scaling sx, sy
##
##dist = sqrt(dx.^2 + dy.^2);
##
##meandist = mean(dist(:));  % Ensure dist is a column vector for Octave 3.0.1
##
##scale = sqrt(2)/meandist;
##
##T = [ scale  0     -tx*scale;
##      0     scale  -ty*scale;
##      0     0     1];
##end